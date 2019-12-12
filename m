From: Andrew Jeffery <andrew@aj.id.au>
Date: Thu, 12 Dec 2019 15:32:25 +1030
Subject: [PATCH v2 07/12] drivers/soc: xdma: Add user interface
In-Reply-To: <d5eee648-fc35-5f9e-9c73-5fa76a6e04c9@linux.ibm.com>
References: <1575566112-11658-1-git-send-email-eajames@linux.ibm.com>
 <1575566112-11658-8-git-send-email-eajames@linux.ibm.com>
 <d97de592-d3c6-4683-ab36-4ea2e8bd27b7@www.fastmail.com>
 <d5eee648-fc35-5f9e-9c73-5fa76a6e04c9@linux.ibm.com>
Message-ID: <2fca83fb-b83a-4adb-9ff2-0658db1b2c66@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Thu, 12 Dec 2019, at 07:13, Eddie James wrote:
> 
> On 12/10/19 9:48 PM, Andrew Jeffery wrote:
> >
> > On Fri, 6 Dec 2019, at 03:45, Eddie James wrote:
> >> +		}
> >> +	} else {
> >> +		mutex_lock(&ctx->file_lock);
> >> +
> >> +		rc = wait_event_interruptible(ctx->wait, !ctx->current_client);
> >> +		if (rc) {
> >> +			mutex_unlock(&ctx->file_lock);
> >> +			return -EINTR;
> >> +		}
> >> +	}
> >> +
> >> +	aspeed_xdma_start(ctx, &op, ctx->vga_phys + offs, client);
> >> +
> >> +	mutex_unlock(&ctx->file_lock);
> > You've used file_lock here to protect aspeed_xdma_start() but start_lock
> > above to protect aspeed_xdma_reset(), so it seems one client can disrupt
> > another by resetting the engine while a DMA is in progress?
> 
> 
> That's correct, that is the intention. In case the transfer hangs, 
> another client needs to be able to reset and clear up a blocking transfer.

Ah. Can we log a noisy warning about resetting the engine while a DMA is
in progress then? I'd hate to debug this otherwise. The more information
we can log about both clients the better.

We still need to make sure we're using consistent locking, even if we wind
up with nested locking.

> >> +
> >> +static int aspeed_xdma_release(struct inode *inode, struct file *file)
> >> +{
> >> +	struct aspeed_xdma_client *client = file->private_data;
> >> +
> >> +	if (client->ctx->current_client == client)
> >> +		client->ctx->current_client = NULL;
> > Shouldn't we also cancel the DMA op? This seems like a DoS risk: set up
> > a non-blocking, large downstream transfer then close the client. Also risks
> > scribbling on memory we no-longer own given we don't cancel/wait for
> > completion in vm close callback?
> 
> 
> Right, better wait for completion. There's no way to cancel a transfer.

Right, that's handy context.

Cheers,

Andrew
