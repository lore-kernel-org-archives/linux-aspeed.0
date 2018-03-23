From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Fri, 23 Mar 2018 16:51:16 +0100
Subject: [PATCH 0/5] serial: implement flow control for ASPEED VUART driver
In-Reply-To: <20180321025241.19785-1-jk@ozlabs.org>
References: <20180321025241.19785-1-jk@ozlabs.org>
Message-ID: <20180323155116.GA31423@kroah.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Mar 21, 2018 at 10:52:36AM +0800, Jeremy Kerr wrote:
> This series implements flow control for the ASPEED VUART driver. This
> hardware is slightly unusual in that the RX data rate can quickly
> overwhelm the flip buffer code, so the ldisc-driven throttle/unthrottle
> mechanisms don't entirely solve the problem.
> 
> To do this, we have a couple of minor changes to the tty core, as well
> as an update to the tty proc interface to display buffer overrun metrics
> (entirely optional, but does allow us to see the problem).
> 
> Then, we implement the standard throttle mechanism, and augment it with
> a fast-path to throttle if we overrun the flip buffers before the ldisc
> has had a chance to run.
> 
> Questions and comments most welcome; I'm fairly new to the tty layer.

I've applied patch 2 here, can you redo the series again after fixing up
the first one and include the v2 of patch 5 so it's easier for me to
figure out what to really apply here?

thanks,

greg k-h
