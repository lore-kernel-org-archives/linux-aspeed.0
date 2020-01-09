From: Andrew Jeffery <andrew@aj.id.au>
Date: Thu, 09 Jan 2020 16:23:34 +1030
Subject: [PATCH v4 07/12] soc: aspeed: xdma: Add user interface
In-Reply-To: <1577993276-2184-8-git-send-email-eajames@linux.ibm.com>
References: <1577993276-2184-1-git-send-email-eajames@linux.ibm.com>
 <1577993276-2184-8-git-send-email-eajames@linux.ibm.com>
Message-ID: <4a8922c3-4062-4c57-bf2a-33b8f9b965f7@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Fri, 3 Jan 2020, at 05:57, Eddie James wrote:
> +static ssize_t aspeed_xdma_write(struct file *file, const char __user *buf,
> +				 size_t len, loff_t *offset)
> +{
> +	int rc;
> +	struct aspeed_xdma_op op;
> +	struct aspeed_xdma_client *client = file->private_data;
> +	struct aspeed_xdma *ctx = client->ctx;
> +
> +	if (len != sizeof(op))
> +		return -EINVAL;
> +
> +	rc = copy_from_user(&op, buf, len);
> +	if (rc)
> +		return rc;
> +
> +	if (!op.len || op.len > client->size ||
> +	    op.direction > ASPEED_XDMA_DIRECTION_UPSTREAM)
> +		return -EINVAL;
> +
> +	if (file->f_flags & O_NONBLOCK) {
> +		if (!mutex_trylock(&ctx->file_lock))
> +			return -EAGAIN;
> +
> +		if (READ_ONCE(ctx->current_client)) {
> +			mutex_unlock(&ctx->file_lock);
> +			return -EBUSY;
> +		}
> +	} else {
> +		mutex_lock(&ctx->file_lock);
> +
> +		rc = wait_event_interruptible(ctx->wait, !ctx->current_client);
> +		if (rc) {
> +			mutex_unlock(&ctx->file_lock);
> +			return -EINTR;
> +		}
> +	}
> +
> +	aspeed_xdma_start(ctx, &op, client->phys, client);

As aspeed_xdma_start() has to take start_lock, if O_NONBLOCK is set we will
potentially violate its contract if the engine is currently being reset. We could
avoid this by adding

    if (READ_ONCE(ctx->in_reset))
        return -EBUSY;

before mutex_trylock(&ctx->file_lock) in the O_NONBLOCK path.

Anyway, I think I've convinced myself the locking isn't wrong. It's possible
that it could be improved, but I think we're hitting the point of diminishing
returns.

Andrew
