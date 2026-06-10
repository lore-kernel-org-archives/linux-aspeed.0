Return-Path: <linux-aspeed+bounces-4212-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0082ACD8CA8
	for <linux-aspeed@archiver.kernel.org>; Wed, 10 Jun 2026 02:26:33 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gZqQw4Hpkz2xjN;
	Wed, 10 Jun 2026 12:26:32 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781058392;
	cv=none; b=oy7JKyobYxRHZTGa/WY3DgpcYzIgRQAYO+DQPvF066BrxB5f6WMjjkFNFvieSKpd4j1jH4I7gfM8OwT4LbgxKD+RXzaAwNucBPRFXdCHITmJkRYGl+45bMf8Kv2a7tocYLp5bbQWQ6mP4Y9Et93DPd12zH4Ezddj+RNVJLbteMbbwkpsEnJfb2gA9H5IzGJVw4CVrgtJAd9tbF0GSf76HJ7tFFjL7oMFTb4hp5/eFu/pmZAPuCmcwQUYPSk5Exl+bMI7tLUE038DOuTGfuQFnj/tSFConNC8Ckae+wOBsCI02EybgH8RGqCSygupAN0RhHvCxgqTzk1doStuhwK/gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781058392; c=relaxed/relaxed;
	bh=jv0HD0eGv0qPg6iGVBj10nHoDRm9zAdKO2FRbjIunyQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ekwlKKjpZFGyuD3stW7W+4LOrmbNmblxt3dIGIRR4etb5uehQH0qQlofTD5BIKXQAM+2K1hUeV5r/BDR76Wyr1jPgcRAgU9Ou0t0KTNBr2pbyyIhM/c0E4ei2q//31foJ+tolMP82otmTTu6KYW4MXu1ee3J9y8E0XpB/xEuE5CQjldDyEoNAOWWZUUasG4MUaKPgiB4EtfSECR3d+uzThdwER+ugtL3arTYrFcEcIZOtofLUA+/TaE4flABVzP6nY7BjR4vAvcjtK3tYI7a8WpooTlBXIDvfz1bJdHZVPdbXHzPv4ch39gZyEMMm22dZ0aBezqVg+7UjBvYfKSJiw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=nAPENbWl; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=nAPENbWl;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gZqQv2qgyz2xdb
	for <linux-aspeed@lists.ozlabs.org>; Wed, 10 Jun 2026 12:26:31 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1781058389;
	bh=jv0HD0eGv0qPg6iGVBj10nHoDRm9zAdKO2FRbjIunyQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=nAPENbWlXsaOxC7cEGzRp2W+9J+GQNQ/QiOaOCPOJbUlt9wtOMOd2v0ya5XHwm4AC
	 knQMKsrjmB6FStM8SJVR489rkmNRc/tMyF9Nd8HofsoBTpuS3kyvit4rSr3/nGX/x3
	 QmSuRYEymf9w4R5mbFJ+WRId4HVG6GX0pCCOQTBfls0iK0Z9wev9r/sGoHgkQg10vg
	 g/cK1cp9nZ6Qo8mQbIMqJC1Q1cKk5P4CSygYgF6Qm0Mq6eJjL8+b3E0GIGxTqesYrs
	 cOWXspkx8zkLLmTXmlIr5PAGBxeJQeqlbh8MSYdhIgPf2Zs+igcK84xNGnw2FP8qZ+
	 uDp5DeZcsrLgg==
Received: from [192.168.68.117] (unknown [180.150.112.11])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 1565760A0E;
	Wed, 10 Jun 2026 10:26:29 +0800 (AWST)
Message-ID: <033f2657ae6a94ad13d22f717a2900afb75d892d.camel@codeconstruct.com.au>
Subject: Re: [PATCH v4] soc: aspeed: lpc-snoop: Fix usercopy overflow in
 snoop_file_read
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Karthikeyan KS <karthiproffesional@gmail.com>
Cc: joel@jms.id.au, andrew@aj.id.au, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Date: Wed, 10 Jun 2026 11:56:28 +0930
In-Reply-To: <20260601125214.2071019-1-karthiproffesional@gmail.com>
References: 
	<1e2b77c7916259e3e269d19f637c29427c175350.camel@codeconstruct.com.au>
	 <20260601125214.2071019-1-karthiproffesional@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
X-Mailing-List: linux-aspeed@lists.ozlabs.org
List-Id: <linux-aspeed.lists.ozlabs.org>
List-Help: <mailto:linux-aspeed+help@lists.ozlabs.org>
List-Owner: <mailto:linux-aspeed+owner@lists.ozlabs.org>
List-Post: <mailto:linux-aspeed@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linux-aspeed/>,
  <https://lists.ozlabs.org/pipermail/linux-aspeed/>
List-Subscribe: <mailto:linux-aspeed+subscribe@lists.ozlabs.org>,
  <mailto:linux-aspeed+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-aspeed+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-aspeed+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0

Hi Karthikeyan,

On Mon, 2026-06-01 at 12:52 +0000, Karthikeyan KS wrote:
> put_fifo_with_discard() acts as both producer and consumer on the kfifo:
> it calls kfifo_skip() (advances out) and kfifo_put() (advances in) from
> the IRQ handler without synchronizing with snoop_file_read(), which also
> consumes via kfifo_to_user(). On SMP systems this concurrent access can
> leave (in - out) larger than the ring buffer, so __kfifo_to_user()'s clam=
p
> to (in - out) is ineffective and kfifo_copy_to_user() can attempt a
> copy_to_user() past the kmalloc-2k backing store:
>=20
> =C2=A0 usercopy: Kernel memory exposure attempt detected from SLUB object
> =C2=A0 'kmalloc-2k' (offset 0, size 2049)!
> =C2=A0 kernel BUG at mm/usercopy.c!
> =C2=A0 Call trace:
> =C2=A0=C2=A0 usercopy_abort
> =C2=A0=C2=A0 __check_heap_object
> =C2=A0=C2=A0 __check_object_size
> =C2=A0=C2=A0 kfifo_copy_to_user
> =C2=A0=C2=A0 __kfifo_to_user
> =C2=A0=C2=A0 snoop_file_read
> =C2=A0=C2=A0 vfs_read
>=20
>=20
> Serialize kfifo access with a per-channel spinlock. copy_to_user()
> runs after dropping the lock, since it may sleep on a page fault.
>=20
> Fixes: 3772e5da4454 ("drivers/misc: Aspeed LPC snoop output using misc ch=
ardev")
> Cc: stable@vger.kernel.org
> Signed-off-by: Karthikeyan KS <karthiproffesional@gmail.com>
> ---
> Andrew,
>=20
> Thanks for the review.
>=20
> > This seems inappropriate and I expect is flagged if you compile with
> > CONFIG_PROVE_LOCKING=3Dy or CONFIG_DEBUG_ATOMIC_SLEEP=3Dy
>=20
> v4 drains the kfifo into a kernel buffer via kfifo_out() under
> the lock, then performs copy_to_user() after dropping it.
> (cf. drivers/gpio/gpiolib-cdev.c, which drains under its event lock
> and copies outside it.)
>=20
> > ensure you develop, build and test on recent releases
>=20
> Tested on both v7.1-rc5 and v7.1-rc6 with PROVE_LOCKING,
> DEBUG_ATOMIC_SLEEP and HARDENED_USERCOPY enabled: read path
> round-trips correctly, no lockdep splats, no atomic-sleep
> warnings, no usercopy aborts.
>=20
> Changes since v3:
> - Replaced kfifo_to_user() with kfifo_out() + copy_to_user()
> =C2=A0 to avoid sleeping under spinlock
> - Rebased onto v7.1-rc6
>=20
> =C2=A0drivers/soc/aspeed/aspeed-lpc-snoop.c | 24 ++++++++++++++++++++----
> =C2=A01 file changed, 20 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/soc/aspeed/aspeed-lpc-snoop.c b/drivers/soc/aspeed/a=
speed-lpc-snoop.c
> index b03310c0830d..0fe463020e25 100644
> --- a/drivers/soc/aspeed/aspeed-lpc-snoop.c
> +++ b/drivers/soc/aspeed/aspeed-lpc-snoop.c
> @@ -74,6 +74,7 @@ struct aspeed_lpc_snoop_channel_cfg {
> =C2=A0struct aspeed_lpc_snoop_channel {
> =C2=A0	const struct aspeed_lpc_snoop_channel_cfg *cfg;
> =C2=A0	bool enabled;
> +	spinlock_t		lock;
> =C2=A0	struct kfifo		fifo;
> =C2=A0	wait_queue_head_t	wq;
> =C2=A0	struct miscdevice	miscdev;
> @@ -115,6 +116,7 @@ static ssize_t snoop_file_read(struct file *file, cha=
r __user *buffer,
> =C2=A0{
> =C2=A0	struct aspeed_lpc_snoop_channel *chan =3D snoop_file_to_chan(file)=
;
> =C2=A0	unsigned int copied;
> +	u8 *buf;

Can use the cleanup helpers again here:

   u8 *buf __free(kfree) =3D NULL;

> =C2=A0	int ret =3D 0;
> =C2=A0
> =C2=A0	if (kfifo_is_empty(&chan->fifo)) {
> @@ -125,11 +127,22 @@ static ssize_t snoop_file_read(struct file *file, c=
har __user *buffer,
> =C2=A0		if (ret =3D=3D -ERESTARTSYS)
> =C2=A0			return -EINTR;
> =C2=A0	}
> -	ret =3D kfifo_to_user(&chan->fifo, buffer, count, &copied);
> -	if (ret)
> -		return ret;
> =C2=A0
> -	return copied;
> +	buf =3D kmalloc(SNOOP_FIFO_SIZE, GFP_KERNEL);

I expect using count clamped to SNOOP_FIFO_SIZE might be a better
option here? The clamp below can be moved here.

I'm not enamoured with the bounce buffer, but I guess it solves the
problem.

> +	if (!buf)
> +		return -ENOMEM;
> +
> +	spin_lock_irq(&chan->lock);
> +	copied =3D kfifo_out(&chan->fifo, buf,
> +			=C2=A0=C2=A0 min_t(size_t, count, SNOOP_FIFO_SIZE));

This is handled by kfifo_out() as discussed previously, but also see
the above. You may want to check that count doesn't exceed UINT_MAX
though, in the event that SIZE_MAX > UINT_MAX.

> +	spin_unlock_irq(&chan->lock);

Recently the kernel gained cleanup helpers. scoped_guard() would be
handy here, however the kfifo API also provides kfifo_out_spinlocked().
I'd use that as it is at least idiomatic.

> +
> +	ret =3D copied;
> +	if (copied && copy_to_user(buffer, buf, copied))
> +		ret =3D -EFAULT;
> +
> +	kfree(buf);
> +	return ret;
> =C2=A0}
> =C2=A0
> =C2=A0static __poll_t snoop_file_poll(struct file *file,
> @@ -153,9 +166,11 @@ static void put_fifo_with_discard(struct aspeed_lpc_=
snoop_channel *chan, u8 val)
> =C2=A0{
> =C2=A0	if (!kfifo_initialized(&chan->fifo))
> =C2=A0		return;
> +	spin_lock(&chan->lock);
> =C2=A0	if (kfifo_is_full(&chan->fifo))
> =C2=A0		kfifo_skip(&chan->fifo);
> =C2=A0	kfifo_put(&chan->fifo, val);
> +	spin_unlock(&chan->lock);

I prefer we use scoped_guard() here.

> =C2=A0	wake_up_interruptible(&chan->wq);
> =C2=A0}
> =C2=A0
> @@ -228,6 +243,7 @@ static int aspeed_lpc_enable_snoop(struct device *dev=
,
> =C2=A0		return -EBUSY;
> =C2=A0
> =C2=A0	init_waitqueue_head(&channel->wq);
> +	spin_lock_init(&channel->lock);
> =C2=A0
> =C2=A0	channel->cfg =3D cfg;
> =C2=A0	channel->miscdev.minor =3D MISC_DYNAMIC_MINOR;

