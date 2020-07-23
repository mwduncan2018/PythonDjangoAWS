from django import forms
from crispy_forms.helper import FormHelper
from crispy_forms.layout import Submit, Layout  # basically, adds a submit button to the form
from crispy_forms.bootstrap import StrictButton, InlineRadios


class NameForm(forms.Form):
    your_name = forms.CharField(label='Your name', max_length=10)


class MessageForm(forms.Form):
    def __init__(self, *args, **kwargs):
        super(MessageForm, self).__init__(*args, **kwargs)

        # Crispy-forms configuration
        self.helper = FormHelper()
        self.helper.form_id = 'id-messageForm'
        self.helper.form_method = 'post'
        self.helper.form_action = ''
        self.helper.form_tag = True
        #self.helper.add_input(Submit('submit', 'Submit'))

        # Crispy-forms Bootstrap3
        self.helper.form_class = 'form-horizontal'
        self.helper.label_class = 'col-lg-2'
        self.helper.field_class = 'col-lg-8'
        self.helper.layout = Layout(
            InlineRadios(
                'submitted_by',
                id='radioSubmittedBy',
                css_class='radio-custom-duncan',
            ),
            'message',
            InlineRadios(
                'mood',
                id='radioMood',
                css_class='radio-custom-duncan',
            ),
            StrictButton(
                content="Submit Message",
                name="btnSubmit",
                type="submit",
                value="Submit Message",
                css_class='btn btn-outline-success my-2 my-sm-0'
            ),
        )

    ANIMAL_CHOICES = (
        ('Bison', 'Bison'),
        ('Black Puma', 'Black Puma'),
        ('Elk', 'Elk'),
        ('Fox', 'Fox'),
        ('Gorilla', 'Gorilla'),
        ('Grizzly', 'Grizzly'),
        ('Hair Bear', 'Hair Bear'),
        ('Kangaroo', 'Kangaroo'),
        ('Lion', 'Lion'),
        ('Orca', 'Orca'),
        ('Otter', 'Otter'),
        ('Owl', 'Owl'),
        ('Penguin', 'Penguin'),
        ('Polar Bear', 'Polar Bear'),
        ('Puma', 'Puma'),
        ('Rabbit', 'Rabbit'),
        ('Wolf', 'Wolf'),
        ('Yahweh', 'Yahweh'),
    )
    submitted_by = forms.ChoiceField(
        label = 'Submitted By',
        choices = ANIMAL_CHOICES,
        required = True,
    )

    MOOD_CHOICES = (
        ('Happy', 'Happy'),
        ('Excited', 'Excited'),
        ('Cheerful', 'Cheerful'),
        ('Reflective', 'Reflective'),
        ('Humorous', 'Humorous'),
        ('Whimsical', 'Whimsical'),
        ('Romantic', 'Romantic'),
        ('Horny', 'Horny'),
        ('Violated', 'Violated'),
        ('High', 'High'),
        ('Drunk', 'Drunk'),
        ('Trippin Balls', 'Trippin Balls'),
        ('Angry', 'Angry'),
        ('Gloomy', 'Gloomy'),
        ('Sad', 'Sad'),
        ('Depressed', 'Depressed')
    )
    mood = forms.ChoiceField(
        label = 'Mood',
        choices = MOOD_CHOICES,
        required = True,
    )

    message = forms.CharField(
        widget = forms.Textarea,
        label = 'Message',
        max_length = 1000,
    )

    send_email = forms.BooleanField(
        label = "Send Email?",
        required = False,
    )
