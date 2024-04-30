From: Paul Menzel <pmenzel@molgen.mpg.de>
Date: Tue, 30 Apr 2024 12:21:45 +0200
Subject: [PATCH v7 0/2] modify Signed-off-by field
In-Reply-To: <CAK=2Bxt=WK4AdktNZDN2iXjk3ga9WRqUm9JQHoNjRnrW8hVt0Q@mail.gmail.com>
References: <20240430045853.3894633-1-Kelly_Hung@asus.com>
 <a21672d7-82dd-44a9-b301-94aa1537b75c@molgen.mpg.de>
 <CAK=2Bxt=WK4AdktNZDN2iXjk3ga9WRqUm9JQHoNjRnrW8hVt0Q@mail.gmail.com>
Message-ID: <94b41f0d-a32b-4854-8528-91341a0a3bb8@molgen.mpg.de>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Dear Chia,


Thank you for your reply. I am sorry, this causes so much trouble.


Am 30.04.24 um 12:04 schrieb Chia Li Hung:
> Paul Menzel ? 2024?4?30? ?? ??2:48???

>> Am 30.04.24 um 06:58 schrieb Kelly Hung:
>>> For the warning message:
>>> From: Kelly Hung '<ppighouse@gmail.com>' != 'Signed-off-by: Kelly Hung <Kelly_Hung@asus.com>'
>>>
>>> I replaced Kelly_Hung at asus.com with my private Gmail account.
>>>
>>> Due to a security issue with ASUS's mail server, I am unable to use
>>> ASUS's mail system to send patches out from my build server.
>>> So I executed git send-email using my private gmail account.
>>
>> To put light on ASUS? upstream work, using your company address would be
>> nice in my opinion. Do you have it configured everything in git
>> (`~/.gitconfig`)?
>>
>>       git config --global user.name "Kelly Hung"
>>       git config --global user.email Kelly_Hung at asus.com

> Below is my git configuration.
> [user]
>          name = Kelly Hung
>          email = Kelly_Hung at asus.com
> [sendemail]
>          smtpserver = smtp.gmail.com
>          smtpEncryption = tls
>          smtpUser = ppighouse at gmail.com
>          smtpServerPort = 587
> 
> I made sure the "From" value after executing git format-patch was my ASUS
> email address.
> 
> From: Kelly Hung <Kelly_Hung@asus.com>
> Date: Thu, 29 Feb 2024 16:45:02 +0800
> Subject: [PATCH v7 1/2] dt-bindings: arm: aspeed: add ASUS X4TF board
> 
> Since my smtp server is Gmail, when I run send-gmail it replaces my "From"
> value with the Gmail account. I asked ASUS IT for assistance today and
> tried to get an SMTP acount.

*A thing you should know if you are using multiple email accounts with 
`git send-email`* [1] says to use

     git send-email --from ppighouse at gmail.com 000*.patch


Kind regards,

Paul


[1]: https://sjp38.github.io/post/git_send_email_multiple_email_caution/
