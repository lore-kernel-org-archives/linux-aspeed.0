From: Oskar Senft <osk@google.com>
Date: Tue, 16 Nov 2021 19:59:28 -0500
Subject: vga_pw sysfs file
In-Reply-To: <CACPK8Xc_B4T-xAcQ7sSqOuVLpwBw69mmj7=5T_opr2AqUs7ThQ@mail.gmail.com>
References: <CABoTLcR2bHQCgV+ooVGE5GJ5NOeK1irDgg0P-rfErA=xbit0vg@mail.gmail.com>
 <CACPK8Xc_B4T-xAcQ7sSqOuVLpwBw69mmj7=5T_opr2AqUs7ThQ@mail.gmail.com>
Message-ID: <CABoTLcQP+kSD2zO2O-_U23Xmi1e1YrjqVDRy3sCviXJ5K9pruw@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Joel

> > In uart_render_controller, however, we're checking whether the bottom
> > 8 bit equal to 0xa8 (why are we not checking for != 0 here?)
>
> I think you found a mistake in the new sysfs file. I can't recall why
> I masked the value the way I did.

Ha, and I thought I'd have to argue my case ;-)

> Thanks for investigating this. I'll send a patch to the kernel and if
> you could test it that would be appreciated.

Absolutely. I assume this will just be a 1-liner. I have the system
setup and can test at any time.

Alternatively, I'd also be happy to send it through.

Thanks
Oskar.
