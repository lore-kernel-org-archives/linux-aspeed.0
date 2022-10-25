From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Wed, 26 Oct 2022 09:29:23 +1100
Subject: [PATCH] usb: gadget: aspeed: fix buffer overflow
In-Reply-To: <CAGm54UE1oS1N_hn4RKuF8a+OWgfvJ-OCc0-uju4mXbtz-jw8VA@mail.gmail.com>
References: <20221024094853.2877441-1-yulei.sh@bytedance.com>
	 <661b43881b7f8764919847f29c0daf1866441090.camel@kernel.crashing.org>
	 <CAGm54UE1oS1N_hn4RKuF8a+OWgfvJ-OCc0-uju4mXbtz-jw8VA@mail.gmail.com>
Message-ID: <49d97f97e63edb70392279845186547d73b2290e.camel@kernel.crashing.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, 2022-10-25 at 14:21 +0800, Lei Yu wrote:
> 

> This case is treated as an error and we do not care about the
> following data.
> Similarly, if we change the MTU in BMC and let BMC ping the OS, the
> OS
> kernel does not crash and it gets RX errors, and the ping fails.
> 
> ?# ifconfig usb0
> ?usb0: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>? mtu 1500
> ???????? ...
> ???????? RX packets 85? bytes 15380 (15.0 KiB)
> ???????? RX errors 51? dropped 0? overruns 0? frame 51
> 
> With this patch, we get the similar behavior on BMC that the RX
> errors
> are increasing.
> 
> > Additionally, I'm curious, why in this specific case is the device
> > sending more data than
> > the buffer can hold ? The MTU change should have resulted in
> > buffers being re-allocated no ?
> 
> The issue is found in a rare case during BIOS boot, we assume that
> BIOS is sending unexpected data to BMC for unknown reasons.

Ok thanks.

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>


> > Or did you change the MTU on the remote and not on the local device
> > ?
> > 
> 
> Yes, the MTU is changed to 2000 in OS and kept 1500 on BMC, then the
> issue is reproduced. (see detailed steps in the above email).
> 
> The reason we made the above test is because we are trying to
> reproduce the behavior as BIOS, and from the logs it looks like it's
> sending a packet larger than MTU. Then we tried to adjust the MTU on
> the OS side and reproduced the issue.

