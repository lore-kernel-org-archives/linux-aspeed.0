From: Oskar Senft <osk@google.com>
Date: Thu, 5 Sep 2019 10:41:13 -0400
Subject: [PATCH v2 2/3] dt-bindings: serial: 8250: Add documentation for
 espi-enabled.
In-Reply-To: <f1d2757119807a48833eba193cd9b443dde0ccba.camel@ozlabs.org>
References: <20190731013404.243755-1-osk@google.com>
 <20190731013404.243755-2-osk@google.com>
 <b4670171-e161-4d7a-91dc-a1e5a95f7dbc@www.fastmail.com>
 <f1d2757119807a48833eba193cd9b443dde0ccba.camel@ozlabs.org>
Message-ID: <CABoTLcTR-iNEftk8ThnyBKn0qD2+jTAOFmZAdGciVXj6KJJcww@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Andrew and Jeremy

Thanks for both your input, that was helpful. I'm sorry it took me so long
to get back to this. I hope it's in better shape now.

> Given it's ASPEED-specific I expect you should use a vendor prefix for the
> > property, e.g. aspeed,espi-enabled.
>
That was a very good point.


> > However, as I understand it you want to determine what polarity the SIRQ
> > should be regardless of which of eSPI or LPC are enabled, so I don't
> think
> > the property name should be an explicit statement about eSPI. Maybe
> > "aspeed,sirq-polarity-sense"?
>
> Yep, +1 on Andrew's comments here. This property isn't an indication on
> whether espi is enabled, but a method to detect it.
>
I agree. I was so focused on functionality that I didn't look at this with
a wider view.

I'll send v3 of the patch that contains appropriate changes. I'll also
include further lists and individuals to get OKs as needed.

Thanks
Oskar.
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20190905/b5d5a676/attachment.htm>
