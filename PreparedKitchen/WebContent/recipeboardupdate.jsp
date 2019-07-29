<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>        
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="static/base.css" />
<script type="text/javascript"
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.5/css/bootstrap.min.css" />
<script type="text/javascript"
	src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.5/js/bootstrap.min.js"></script>
<script type="text/javascript" src="js/jquery.form.min.js"></script>
<!-- include summernote css/js-->
<link href="summernote/dist/summernote.css" rel="stylesheet"
	type="text/css">
<script type="text/javascript" src="summernote/dist/summernote.js"></script>
<script type="text/javascript"
	src="summernote/dist/lang/summernote-ko-KR.js"></script>
<script type="text/javascript">

	
	$(function() {
		
	 	 $('#summernote').summernote({
		  height: 300,                 
          minHeight: null,           
          maxHeight: null,            
          focus: true,               
          lang : 'ko-KR',
          toolbar: [
        	    ['style', ['bold', 'italic', 'underline', 'clear']],
        	    ['font', ['strikethrough', 'superscript', 'subscript']],
        	    ['fontsize', ['fontsize']],
        	    ['color', ['color']],
        	    ['para', ['ul', 'ol', 'paragraph']],
        	    ['height', ['height']],
        	    ['insert', ['link', 'picture']],
        	  ],
         callbacks: {
           onImageUpload: function(files, editor, welEditable) {
        	   console.log(files);
	        	  console.log(editor);
	        	  console.log(welEditable);
           	for (var i = files.length - 1; i >= 0; i--) {
              sendFile(files[i], this);
            }
          }
        }
	  });
	});

	function sendFile(file, editor) {
        // 파일 전송을 위한 폼생성
 		data = new FormData();
 	    data.append("uploadFile", file);
 	    $.ajax({ // ajax를 통해 파일 업로드 처리
 	        data : data,
 	        type : "POST",
 	        url : "recipeboard.do?command=imgupload",
 	        cache : false,
 	        contentType : false,
 	        enctype: 'multipart/form-data',
 	        processData : false,
 	        success : function(data) { // 처리가 성공할 경우
                // 에디터에 이미지 출력
 	        	$(editor).summernote('editor.insertImage', data.url);
 	        }
 	    });
 	}
	
</script>
</head>
<body>
	<header>
		<!-- 가장 위 header.jsp 링크 들어 갈 곳 -->
		<%@ include file="static/header.jsp"%>
	</header>
	<section>
		<div class="container">
			<h1 class="page-header">update</h1>
			<form action="recipeboard.do" method="post" class="form-horizontal">
				<input type="hidden" name="command" value="updateres"> <input
					type="hidden" name="recipeBoard_no"
					value="${recipeBoardDto.recipeBoard_no }" />
				<div class="form-group">
					작성일<input type="text" class="form-control"
						name="recipeBoard_regdate"
						value="${recipeBoardDto.recipeBoard_regdate }" readonly="readonly" />
				</div>
				<div class="form-group">
					제목<input type="text" class="form-control" name="recipeBoard_title"
						value="${recipeBoardDto.recipeBoard_title }" />
				</div>
				<div class="form-group">
					<textarea name="recipeBoard_content" id="summernote">${recipeBoardDto.recipeBoard_content }</textarea>
				</div>
				<div class="form-group">
					<input type="submit" value="수정" class="btn btn-default" /> <input
						type="button" value="취소" class="btn btn-default"
						onclick="location.href='recipeboard.do?command=selectone&recipeBoard_no=${recipeBoardDto.recipeBoard_no}'" />
					<input type="button" value="목록" class="btn btn-default"
						onclick="location.href='recipeboard.do?command=list'" />
				</div>
			</form>
		</div>
	</section>
	<%@ include file="static/remocon.jsp"%>
	<footer>
		<!-- 가장 밑 footer.jsp 링크 들어 갈 곳 -->
		<%@ include file="static/footer.jsp"%>
	</footer>
</body>
</html>