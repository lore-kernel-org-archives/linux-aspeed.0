From: Andrew Jeffery <andrew@aj.id.au>
Date: Fri, 20 Dec 2019 07:46:18 +1030
Subject: [PATCH v3 07/12] soc: aspeed: xdma: Add user interface
In-Reply-To: <22d81b7d-4f1c-30b9-e895-1f38a862462e@linux.ibm.com>
References: <1576681778-18737-1-git-send-email-eajames@linux.ibm.com>
 <1576681778-18737-8-git-send-email-eajames@linux.ibm.com>
 <de68ff11-0942-422a-b233-ff578b06eefc@www.fastmail.com>
 <22d81b7d-4f1c-30b9-e895-1f38a862462e@linux.ibm.com>
Message-ID: <700f857c-0d99-4e7e-a969-191c5afd10f8@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Fri, 20 Dec 2019, at 02:30, Eddie James wrote:
> 
> On 12/18/19 7:19 PM, Andrew Jeffery wrote:
> >
> > On Thu, 19 Dec 2019, at 01:39, Eddie James wrote:
> >> +			mutex_unlock(&ctx->file_lock);
> >> +			return -EBUSY;
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
> >> +	aspeed_xdma_start(ctx, &op, client->phys, client);
> >> +
> >> +	mutex_unlock(&ctx->file_lock);
> > Shouldn't we lift start_lock out of aspeed_xdma_start() use that here
> > instead of file_lock? I think that would mean that we could remove
> > file_lock.
> 
> 
> That wouldn't work with the reset though. The reset should hold 
> start_lock as well, but if a client is waiting here with start_lock, 
> we'd never get to the reset if the transfer doesn't complete. I think 
> file_lock is necessary.

Hmm, let me think about this some more.

Andrew
