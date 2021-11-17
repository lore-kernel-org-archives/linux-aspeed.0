From: Joel Stanley <joel@jms.id.au>
Date: Wed, 17 Nov 2021 01:04:31 +0000
Subject: vga_pw sysfs file
In-Reply-To: <CABoTLcQP+kSD2zO2O-_U23Xmi1e1YrjqVDRy3sCviXJ5K9pruw@mail.gmail.com>
References: <CABoTLcR2bHQCgV+ooVGE5GJ5NOeK1irDgg0P-rfErA=xbit0vg@mail.gmail.com>
 <CACPK8Xc_B4T-xAcQ7sSqOuVLpwBw69mmj7=5T_opr2AqUs7ThQ@mail.gmail.com>
 <CABoTLcQP+kSD2zO2O-_U23Xmi1e1YrjqVDRy3sCviXJ5K9pruw@mail.gmail.com>
Message-ID: <CACPK8Xed0JN9drM6Apz=k24K06KT-gnooBjWeu8MAwNjxUNh3g@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, 17 Nov 2021 at 00:59, Oskar Senft <osk@google.com> wrote:
>
> Hi Joel
>
> > > In uart_render_controller, however, we're checking whether the bottom
> > > 8 bit equal to 0xa8 (why are we not checking for != 0 here?)
> >
> > I think you found a mistake in the new sysfs file. I can't recall why
> > I masked the value the way I did.
>
> Ha, and I thought I'd have to argue my case ;-)
>
> > Thanks for investigating this. I'll send a patch to the kernel and if
> > you could test it that would be appreciated.
>
> Absolutely. I assume this will just be a 1-liner. I have the system
> setup and can test at any time.

Here we go:

 https://lore.kernel.org/all/20211117010145.297253-1-joel at jms.id.au/

Thanks for the detailed bug report. Please reply to that mail with
your tested-by once you've confirmed this works.

Cheers,

Joel
