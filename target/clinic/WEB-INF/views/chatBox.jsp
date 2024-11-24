<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Chat</title>
    <!-- Import Materialize CSS -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/css/materialize.min.css">
    <!-- Import jQuery -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>

<div class="container">
    <div class="row">
        <div class="col s12">
            <div class="card">
                <div class="card-content">
                    <span class="card-title">Chat</span>
                    <div id="chatBox" class="chat-box" style="height: 300px; overflow-y: scroll; border: 1px solid #ccc; padding: 10px;">
                        <!-- Messages will be dynamically loaded here -->
                    </div>
                </div>
                <div class="card-action">
                    <div class="input-field">
                        <input type="text" id="message" placeholder="Type your message here...">
                    </div>
                    <button class="btn waves-effect waves-light" id="sendBtn">Send</button>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Import Materialize JS -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/js/materialize.min.js"></script>

<!-- Custom JavaScript -->
<script>
$(document).ready(function() {
    // Load chat messages
    function loadMessages() {
        $.ajax({
            url: 'LoadMessagesServlet', // Servlet to load messages
            method: 'GET',
            success: function(data) {
                $('#chatBox').html(data);
                $('#chatBox').scrollTop($('#chatBox')[0].scrollHeight); // Auto scroll to bottom
            }
        });
    }

    // Send message on button click
    $('#sendBtn').click(function() {
        var message = $('#message').val();
        var receiverId = 1; // Replace with actual receiverId logic

        if (message.trim() !== '') {
            $.ajax({
                url: 'ChatServlet',
                method: 'POST',
                data: {
                    message: message,
                    receiverId: receiverId
                },
                success: function(response) {
                    $('#message').val(''); // Clear input field
                    loadMessages(); // Reload chat messages
                }
            });
        }
    });

    // Auto-load messages every 3 seconds
    setInterval(loadMessages, 3000);

    // Initial load of messages
    loadMessages();
});
</script>

</body>
</html>
