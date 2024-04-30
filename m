From: Paul Menzel <pmenzel@molgen.mpg.de>
Date: Tue, 30 Apr 2024 08:48:09 +0200
Subject: [PATCH v7 0/2] modify Signed-off-by field
In-Reply-To: <20240430045853.3894633-1-Kelly_Hung@asus.com>
References: <20240430045853.3894633-1-Kelly_Hung@asus.com>
Message-ID: <a21672d7-82dd-44a9-b301-94aa1537b75c@molgen.mpg.de>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Dear Kelly,


Am 30.04.24 um 06:58 schrieb Kelly Hung:
> For the warning message:
> From: Kelly Hung '<ppighouse@gmail.com>' != 'Signed-off-by: Kelly Hung <Kelly_Hung@asus.com>'
> 
> I replaced Kelly_Hung at asus.com with my private Gmail account.
> 
> Due to a security issue with ASUS's mail server, I am unable to use
> ASUS's mail system to send patches out from my build server.
> So I executed git send-email using my private gmail account.

To put light on ASUS? upstream work, using your company address would be 
nice in my opinion. Do you have it configured everything in git 
(`~/.gitconfig`)?

     git config --global user.name "Kelly Hung"
     git config --global user.email Kelly_Hung at asus.com

Then `git format-patch` and `git send-email` should put

From: Kelly Hung <Kelly_Hung@asus.com>

at the top of the message.


Kind regards,

Paul
