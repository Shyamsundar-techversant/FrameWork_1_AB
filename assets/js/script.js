$(document).ready(function(){
	if(window.history.replaceState){
		window.history.replaceState(null,null,window.location.href);
	}
	let contactId;
	let	contTitle=$('#title'),
		contFirstname=$('#firstname'),
		contLastname=$('#lastname'),
		contGender=$('#gender'),
		contDob=$('#dob'),
		contImg=$('#upload-img'),
		contEmail=$('#email'),
		contPhone=$('#phone'),
		contAddress=$('#address'),
		contPincode=$('#pincode'),
		contStreet=$('#street'),
		contHobby=$('#hobby'),
		contThumb=$('#contactThumb');
		
	let publicContact=document.getElementById('publicUser');

	let	fullName=$('#contact-name'),
		gender=$('#contact-gender'),
		dob=$('#contact-dob'),
		address=$('#contact-address'),
		pincode=$('#contact-pincode'),
		email=$('#contact-email'),
		phone=$('#contact-phone');

	//ADD
	$('#create-cont').on('click',function(){
		setTimeout(()=>{
			$('#contacts-form').trigger('reset');
		},2000);
		document.getElementById('add-edit-head').textContent = "ADD CONTACT";

		$('#add-cont').show();
		$('#edit-cont').hide();	
		if($("#error-data li").length > 0){
			$('#error-data li').remove();
		}
		contThumb.hide();

	});

	$('#add-cont').on('click',function(event){
		event.preventDefault();
		var fileInput = $('#upload-img')[0];
		var file = fileInput.files[0];
		let publicData = publicContact.checked? 1:0 ; 
		let formData = new FormData();
		formData.append('title', contTitle.val());
		formData.append('firstname', contFirstname.val());
		formData.append('lastname', contLastname.val());
		formData.append('gender', contGender.val());
		formData.append('dob', contDob.val());
		if(file){
			formData.append('file', file);
		}
		else{
			alert("phot is required");
		}
		formData.append('email', contEmail.val());
		formData.append('phone', contPhone.val());
		formData.append('address', contAddress.val());
		formData.append('street', contStreet.val());
		formData.append('pincode', contPincode.val());
		formData.append('hobbies',contHobby.val());
		formData.append('public',publicData);
		$.ajax({
			url: '/Frame_work_1_Address_Book/index.cfm?action=addressbook.validateFormAndAddOrEditContact',
			type:'POST',
			data:formData,
			processData:false,
			contentType:false,
			success:function(response){
				console.log(response);
				if(response === "Success"){
					$('#contacts-form').closest('.modal').modal('hide');
					location.reload();
				}
				else{
					addError(response);					
                    let errorDiv = document.getElementById("contact-form-errors");
                    if (errorDiv) {
                        errorDiv.scrollIntoView({ behavior: "smooth", block: "center" });
                    }
				}
			},
			error:function(){
				console.log("Request Failed");
			}
		});
	});

	//Error Data

	function addError(data){
		const errorList = document.getElementById("error-data");
		errorList.innerHTML="";
		
		data.forEach((msg)=>{
			let li= document.createElement('li');
			li.textContent=msg;
			errorList.appendChild(li);
		});

	}

	//VIEW	
		$('.contact-view-btn').on('click', function() {
		// Get the contact ID from data-id attribute
		contactId = $(this).data('id');
		$.ajax({
			url:'/Frame_work_1_Address_Book/index.cfm?action=addressbook.getContactDetails',
			type:'POST',
			data:{
				id:contactId
			},
			success:function(response){
				console.log(response) ;
				const hobbies =	response.hobby_name.split(",");
				let date = new Date(response.dob);
				let formattedDate = date.toISOString().split('T')[0];
				$('#profile-picture').attr('src',`/uploadImg/${response.imagePath}`);
				fullName.text(`${response.titles} ${response.firstName}${response.lastName}`);
				gender.text(`${response.gender_values}`);
				dob.text(formattedDate);
				address.text(`${response.address}`);
				pincode.text(`${response.pincode}`);
				email.text(`${response.email}`);
				phone.text(`${response.phone}`);	
				$('#user-hobbies').text(hobbies); 	
			},
			error:function(){
				console.log("Request Failed");
			}
		});
	});


	//EDIT
	$('.edit-cont-details').on('click',function(){
		document.getElementById('add-cont').style.display="none";
		document.getElementById('edit-cont').style.display="block";
		document.getElementById('add-edit-head').textContent = "EDIT CONTACT";
		contactId=$(this).data('id');	
		contThumb.show();
		document.getElementById('hiddenId').value = contactId;
		if($("#error-data li").length > 0){
			$('#error-data li').remove();
		}
		$.ajax({
			url:'/Frame_work_1_Address_Book/index.cfm?action=addressbook.getContactDetails',
			type:'POST',
			data:{
				id:contactId
			},
			success:function(response){
				console.log(response);
				let public = response.public;
				if(public){
					publicContact.checked=true;
				}
				else{
					publicContact.checked=false;
				}
				const hobbies=	response.hobby_Id.split(",");
				let date = new Date(response.dob);
				let formattedDate = date.toISOString().split('T')[0];
				contTitle.val(response.titleId);
				contFirstname.val(response.firstName);
				contLastname.val(response.lastName);
				contGender.val(response.genderId);
				contDob.val(formattedDate);
				contEmail.val(response.email);
				contPhone.val(response.phone);
				contAddress.val(response.address);
				contPincode.val(response.pincode);
				contStreet.val(response.street);			
				contHobby.val(hobbies);	

				document.getElementById('contactThumb').innerHTML='';
				const imgElement= document.createElement('img');
				imgElement.src= `/uploadImg/${response.imagePath}`;
				imgElement.setAttribute('width','50') ;
				imgElement.setAttribute('height','50') ;	
				document.getElementById('contactThumb').appendChild(imgElement);

			},
			error:function(){
				console.log("Request Failed");
			}
		});

	});
	$('#upload-img').on('change', function(event) {
		const file = event.target.files[0];
		if (file) {
			const reader = new FileReader();
			reader.onload = function(e) {
								const imgElement = document.createElement('img');
								imgElement.src = e.target.result;
								imgElement.alt = 'Uploaded Image';
								imgElement.style.width = '65px';
								imgElement.style.height = '65px';

								const contactDiv = document.getElementById('contactThumb');
								contactDiv.innerHTML = ''; 
								contactDiv.appendChild(imgElement); 
					};	
			reader.readAsDataURL(file); 
		}
	});

	/*
	$('#edit-cont').on('click',function(event){	
		event.preventDefault();
		var fileInput = $('#upload-img')[0];
		var file=fileInput.files[0];
		let formData = new FormData();
		let publicData=publicContact.checked? 1:0 ;
		formData.append('title', contTitle.val());
		formData.append('firstname', contFirstname.val());
		formData.append('lastname', contLastname.val());
		formData.append('gender', contGender.val());
		formData.append('dob', contDob.val());
		if(file){
			formData.append('file', file);
		}
		formData.append('email', contEmail.val());
		formData.append('phone', contPhone.val());
		formData.append('address', contAddress.val());
		formData.append('street', contStreet.val());
		formData.append('pincode', contPincode.val());
		formData.append('hobbies',contHobby.val());
		formData.append('id',contactId);
		formData.append('public',publicData);
		$.ajax({
			url:'Components/main.cfc?method=validateFormAndCreateOrUpdateUser',
			type:'POST',
			data:formData,
			processData:false,
			contentType:false,
			success:function(response){
				console.log(response);
				let data = JSON.parse(response);
				console.log(data);	
				if(data === "Success"){
					$('#contacts-form').closest('.modal').modal('hide');
					location.reload();
				}
				else{
					addError(data);
				}
					
			},
			error:function(){
				console.log("Request Failed");
			}
		});		
	});

	*/

	//DELETE CONTACT
	$('.delete-contact-details').on('click', function() {		
		// Get the contact ID from data-id attribute
		contactId = $(this).data('id');
		$('.modal-backdrop').show();
	});
	$('#delete-cont').on('click',function(){
		$.ajax({
			url:'/Frame_work_1_Address_Book/index.cfm?action=addressbook.deleteContact',
			type:'POST',
			data:{
				id:contactId
			},
			success:function(response){
				if(response === "Success"){					
					$('button.delete-contact-details[data-id="' + contactId + '"]').closest('tr').remove();
					alert("contact deleted successfully");	
				}
				else{
					console.log("error;;");
				}
			},
			error:function(){
				console.log("Request failed");
			}
		});	
		$('#deleteContact').hide();
		$('.modal-backdrop').hide();
	});	
});

