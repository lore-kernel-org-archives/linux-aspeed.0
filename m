From: sudheer v <open.sudheer@gmail.com>
Date: Tue, 25 Jun 2019 10:30:32 +0530
Subject: [patch 0/5] *** DMA based UART driver for AST2500 ***
In-Reply-To: <20190621131729.GA9997@kroah.com>
References: <1561115855-4186-1-git-send-email-open.sudheer@gmail.com>
 <20190621131729.GA9997@kroah.com>
Message-ID: <CAE-5=DTdo4qDUPRw+Giu=bCcpqu7EdLDt5ddDvqLSgGbuqE1Fg@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Greg,
When i last submitted patches, i have not added change-logs.
and also used custom debugs instead of kernel dynamic debugs.
So i have resubmitted the patches , considering you have discarded old set.
I want to send any changes suggested  from now on wards  with versioning
V1,V2...so on.
Is this acceptable for you? or should i submit the patches again as V1 once
again.?

-Sudheer


On Fri, Jun 21, 2019 at 6:47 PM Greg KH <gregkh@linuxfoundation.org> wrote:

> On Fri, Jun 21, 2019 at 04:47:30PM +0530, sudheer.v wrote:
> > From: sudheer veliseti <sudheer.open@gmail.com>
> >
> > Hi,
> > AST2500 has dedicated Uart DMA controller which has 12 sets of
> > Tx and RX channels connected to UART controller directly.
> > Since the DMA controller have dedicated buffers and registers,
> > there would be little benifit in adding DMA framework overhead.
> > So the software for DMA controller is included within the UART driver
> itself.
> >
> > Thanks and Regards
> > Sudheer.V
>
> Is this a v2 of this patch series?
>
> You always have to version your patches and say what changed from the
> previous one, like the documentation says to do.
>
> Please fix this up and resend.
>
> thanks,
>
> greg k-h
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20190625/02944aea/attachment.htm>
