Return-Path: <linux-aspeed+bounces-4243-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2353ACD98CC
	for <linux-aspeed@archiver.kernel.org>; Fri, 12 Jun 2026 00:11:19 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gc0Ks42Cbz2ysW;
	Fri, 12 Jun 2026 10:11:13 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::135" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781199102;
	cv=pass; b=Ko6J+oq8lDmNWbpvxTXpAKvhQ5QX8wdjZ04aZ7GgLu5GOpH96N+wW3VCSeIj21tFqHqVvzvPEcSQQpuTsCAcM9Ab2hhsiDq+G2535YVthlPOJlyWuEsawG/mdtS0Z97iskU05Vs3LeJfhD7OTZP3jfGC3/luKMthMn6U18xiZBZ0Zd/WwF7E5D6bB+RA3aQwRqOddEhCqWGuJ6aum60Xako/XFEozxCn1xgNKiI8/OE1jGaODBn9bIzcpoBXq02ifLuX3usqXhhgQEAXTd7TWqxj2Qk2kblCKW2OYKjyH6mCcd3AwQGTj59Io/gkKJFKZCzLShrc+u735JHN6NQYog==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781199102; c=relaxed/relaxed;
	bh=eGcNmYTnuWW/4cnrYgAMartIFcOB3mho6SW0EPvyL7I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bexB8iPK4IY62woltvRq3iExISfAOhTtR8kFpR9cx0ghOzw83QtsfskdR/oNlSSTEJKqOJE01HusfIlIQ3IUkgyYgP0H3G+uFMO350t9YDrVdW9dqprCOWkfEAvG5yp0eI1c9AxRewEL3+/veAFYTSQ5rKsicV+otqkkCjlkN5QUwv1gyYuQPxEB9gGq76oThKKLyBLQgOA/3jLik+VWrfzGyoB61QiUrgU1QiqkcCvO069uODlfI9pZPWoxXL0f5MNu9bBuULyxpA06r1p0JOu3da8gheP9KR4DWQXOtAvAidJu6bywXOD6kJknivHtoxzVkK7nUqlF3mR4tqblIw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Ohy8h7FQ; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::135; helo=mail-lf1-x135.google.com; envelope-from=karthiproffesional@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Ohy8h7FQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::135; helo=mail-lf1-x135.google.com; envelope-from=karthiproffesional@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gbqSq5TKwz2xjd
	for <linux-aspeed@lists.ozlabs.org>; Fri, 12 Jun 2026 03:31:38 +1000 (AEST)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-5aa619653e4so1158206e87.1
        for <linux-aspeed@lists.ozlabs.org>; Thu, 11 Jun 2026 10:31:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781199090; cv=none;
        d=google.com; s=arc-20240605;
        b=F+c5usWPvjMIE2Yn90961j/jGLsB2hN2qhNoBceG5Z3OtVFR40p9v0k/xKiMzTBlUg
         T3KQpyNaiST8kC3nCmunn/EcwqiYQdqNA7KuQ7Z4g+jiAQglWgaVfSte3MpkYspAoHMv
         CdOlU4JiCes/fiVQnou3UfiD4UxhE8R+VeSrDPA9odKFZCEcM8gczJPg5Qfay4Ir3FYq
         sHtbhPZ8xPnE+3cC+7LX6FfWM1HksSJ5FnKM1T93437ptlWUoJ/V4vZCk9FKiJaOVa6P
         2tK2sH1tRyGfKVmti0bLPnelPpYg3K9yFqaQi2rmbjB5fWO8ChKnLEjxKGam2G7kiwRz
         3NuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=eGcNmYTnuWW/4cnrYgAMartIFcOB3mho6SW0EPvyL7I=;
        fh=zf9gk2YSQKEu9Rd+moqIr5MNW/dRLUbvN/yXbbgxRHY=;
        b=Uvx4kW36E0l+91DrrxbvdM97aUCDhSpuAoRNU1HW/gEadI+BbbqrM43588tA/+w75d
         T5KJ4oQsZFIa4Wazt38zJdh4T/C//DS/PQWKSxCPgA4gYJtqwyNB6BlFdTFXzX+XfsyL
         CSSjIfe/7HU1kip21daU5s77n2Rz8OnWnTjcW4cMSzGaegeeV7fuFtvYVfOrPXHg0pFR
         n8ASTFcgNKlZOcFDtOEu4b2lnKWlPLQOxUWuNE5OVIdOrrvQAND0Jv2DuIEt9gMIt6TC
         FaRteUtONfsJtv5yUttRFExHtSOKmmBtC5mA3LTWL7PgLBFLvRNF/PePInqS4Kp4wJW2
         Z+2w==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781199090; x=1781803890; darn=lists.ozlabs.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eGcNmYTnuWW/4cnrYgAMartIFcOB3mho6SW0EPvyL7I=;
        b=Ohy8h7FQKtzNEWwo8SzI057ED6cuNV0sma2Orx4z9EwmzuXH+pxmzTo3k1rQyefED2
         iZpzjO5500mJoOxE40CaEdq8PwdKqcvBNos3mGEx/qZMejK4h2V4q57E84F6Li2T7/XB
         VW15pIBN6Sk42Fy2f6RIqBDzcifs1ejxUVNfH2kk4jX7jNVKiso80x+ly9GhmnyPujIu
         4mNw/0URivd2YcCXlVwsOrpTVOM3EWRafLTLUOv9W5LO3lYibwNO/V0gvLlQfc8+6twz
         lNI6C1JToiK4PEaG1K+dduAjTOFac904XA3i4UzSGigc1uVidMw1n1I6gCguKpipQHwW
         Smog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781199090; x=1781803890;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eGcNmYTnuWW/4cnrYgAMartIFcOB3mho6SW0EPvyL7I=;
        b=CVbdgPq9vW9Yc7RDdm5NdMqGZnhdnDXCRBdvSJAaVLLhW4fYTmHQJjFkdBJpb4Ftt+
         HNsrBrFBUD090asOKMGLwhUB3ia2fITUtrEeMaClWRR8iNk2w8y6FKv8DneytuGkMHby
         rtolR5yt//gsjiXoKetPFkgR/rJ6he6MGf6s+TnjXUFSTrvTZXa/kjKlI/LSmRgGFf56
         GNIZqj18bAmjMWQD+IJO60aLUuItoaOpVc3jmZSy0GcvjbnQ1tc0LQxDHjWkm6Vwv5om
         XoHeyNEDEh/Q2/iuN9+ASMCQagSENCbXzI8SWJC7C3JCAUPgzdLE3hvI2x9XHupArEYw
         soAg==
X-Forwarded-Encrypted: i=1; AFNElJ9g7bT3b9bN9dD8jfcAbHlYQSSkZ424OuXZcEZDCJcoNNAmswtJAYBGYadU/gICqz1rR5s/Bko8QxBhor4=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yw+nZ6Ko/wA7XH+irDVX1FeOkZPhWcijVXh7Zo6YEWE43NcMwoT
	1z16YEFD4hUr8XbhjWtFXBwUgX8iEkT2SPyVBZRcSR2fqwUFY5ORxPLEJgNVTakXPu3miEmxtbi
	DhBOqeTvynIi2nB6b/jzmSzvHqzOk4Bk=
X-Gm-Gg: Acq92OFFSMGYbsxvr1m6kAx1yTjOiL2pviGPi8ciRoStm+1HEHfzCXdWkcFJDQXUtBE
	3JJxIvHY+HHUGijPI+GrROC/ELzp4jXGvSBXQ3mc73ke6B52RMULuJdMIGnIVOA9QUv/IzUtHVQ
	1Qc2DDlTJNnbGjZTFF6n02TdUvgl45KDDrm33M8fOgBnwUQjsUMroZCnknRkJn1OyvXvJ94LpHe
	kD/oNieBBnublSP0R3IC7sS1C/Xw4zTaSNSEDwxppRBlTpOPVjBdnsy9kP6PWQiTdX9f0EJ1jNC
	OoSEuV6t
X-Received: by 2002:a05:6512:1149:b0:5aa:8827:73be with SMTP id
 2adb3069b0e04-5ad28627d89mr865709e87.24.1781199089495; Thu, 11 Jun 2026
 10:31:29 -0700 (PDT)
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
References: <033f2657ae6a94ad13d22f717a2900afb75d892d.camel@codeconstruct.com.au>
 <20260610172310.163321-1-karthiproffesional@gmail.com> <64f8d88bf4cd72d8120baaa304dfe34bb66cbe0b.camel@codeconstruct.com.au>
In-Reply-To: <64f8d88bf4cd72d8120baaa304dfe34bb66cbe0b.camel@codeconstruct.com.au>
From: karthikeyan K S <karthiproffesional@gmail.com>
Date: Thu, 11 Jun 2026 23:01:18 +0530
X-Gm-Features: AVVi8CcZaPT4EfLqVSDuGGHgBmd9ECASYoQk-992FV8WRgUv1mfAHgZiVN5qp2E
Message-ID: <CAP_JKPu9MTpMUZmg9BY3sxGhmBzgR0E6HnvAT7sQjVUpQp0dSQ@mail.gmail.com>
Subject: Re: [PATCH v5] soc: aspeed: lpc-snoop: Fix usercopy overflow in snoop_file_read
To: Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: joel@jms.id.au, andrew@aj.id.au, Kees Cook <kees@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: multipart/alternative; boundary="00000000000000f1480653fdbbdd"

--00000000000000f1480653fdbbdd
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks Andrew. The __guarded_by annotation and context analysis integration
look good, I wasn't aware of that infrastructure.
Thanks for applying those changes on top.

Karthikeyan

On Thu, Jun 11, 2026 at 8:20=E2=80=AFAM Andrew Jeffery <andrew@codeconstruc=
t.com.au>
wrote:

> Hi Karthikeyan,
>
> On Wed, 2026-06-10 at 17:23 +0000, Karthikeyan KS wrote:
> > put_fifo_with_discard() acts as both producer and consumer on the kfifo=
:
> > it calls kfifo_skip() (advances out) and kfifo_put() (advances in) from
> > the IRQ handler without synchronizing with snoop_file_read(), which als=
o
> > consumes via kfifo_to_user(). On SMP systems this concurrent access can
> > leave (in - out) larger than the ring buffer, so __kfifo_to_user()'s
> clamp
> > to (in - out) is ineffective and kfifo_copy_to_user() can attempt a
> > copy_to_user() past the kmalloc-2k backing store:
> >
> >   usercopy: Kernel memory exposure attempt detected from SLUB object
> >   'kmalloc-2k' (offset 0, size 2049)!
> >   kernel BUG at mm/usercopy.c!
> >   Call trace:
> >    usercopy_abort
> >    __check_heap_object
> >    __check_object_size
> >    kfifo_copy_to_user
> >    __kfifo_to_user
> >    snoop_file_read
> >    vfs_read
> >
> > Serialize kfifo access with a per-channel spinlock. The reader drains
> > into a bounce buffer under the lock with kfifo_out_spinlocked() and the=
n
> > copies to userspace after dropping it, since copy_to_user() may sleep o=
n
> > a page fault.
> >
> > Fixes: 3772e5da4454 ("drivers/misc: Aspeed LPC snoop output using misc
> chardev")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Karthikeyan KS <karthiproffesional@gmail.com>
> > ---
> > Andrew,
> >
> > Thanks for the review.
> >
> > Changes since v4:
> > - Use __free(kfree) for automatic cleanup
> > - Allocate clamped count instead of full SNOOP_FIFO_SIZE
> > - Use kfifo_out_spinlocked() in snoop_file_read
> > - Use scoped_guard(spinlock) in put_fifo_with_discard
> >
> >  drivers/soc/aspeed/aspeed-lpc-snoop.c | 25 +++++++++++++++++++------
> >  1 file changed, 19 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/soc/aspeed/aspeed-lpc-snoop.c
> b/drivers/soc/aspeed/aspeed-lpc-snoop.c
> > index b03310c0830d..c9c87a794228 100644
> > --- a/drivers/soc/aspeed/aspeed-lpc-snoop.c
> > +++ b/drivers/soc/aspeed/aspeed-lpc-snoop.c
> > @@ -11,6 +11,7 @@
> >   */
> >
> >  #include <linux/bitops.h>
> > +#include <linux/cleanup.h>
> >  #include <linux/clk.h>
> >  #include <linux/dev_printk.h>
> >  #include <linux/interrupt.h>
> > @@ -74,6 +75,7 @@ struct aspeed_lpc_snoop_channel_cfg {
> >  struct aspeed_lpc_snoop_channel {
> >       const struct aspeed_lpc_snoop_channel_cfg *cfg;
> >       bool enabled;
> > +     spinlock_t              lock;    /* serialises @fifo: irq produce=
r
> vs reader */
>
> I'd prefer we avoid trailing comments, which it seems you've added this
> time around. Since you did that ...
>
> >       struct kfifo            fifo;
>
> ... in this specific case we can improve on the comment, with:
>
>    struct kfifo fifo __guarded_by(&lock);
>
> More details here:
>
>    https://docs.kernel.org/dev-tools/context-analysis.html
>
> Adding a change along these lines currently produces:
>
>    ../drivers/soc/aspeed/aspeed-lpc-snoop.c:164:32: warning: reading
> variable 'fifo' requires holding spinlock '&aspeed_lpc_snoop_channel::loc=
k'
> [-Wthread-safety-analysis]
>      164 |         if (!kfifo_initialized(&chan->fifo))
>          |                                       ^
>
> I ended up applying this on top of your patch:
>
>    diff --git a/drivers/soc/aspeed/Makefile b/drivers/soc/aspeed/Makefile
>    index b35d74592964..9cba7be8c395 100644
>    --- a/drivers/soc/aspeed/Makefile
>    +++ b/drivers/soc/aspeed/Makefile
>    @@ -4,3 +4,5 @@ obj-$(CONFIG_ASPEED_LPC_SNOOP)          +=3D
> aspeed-lpc-snoop.o
>     obj-$(CONFIG_ASPEED_UART_ROUTING)      +=3D aspeed-uart-routing.o
>     obj-$(CONFIG_ASPEED_P2A_CTRL)          +=3D aspeed-p2a-ctrl.o
>     obj-$(CONFIG_ASPEED_SOCINFO)           +=3D aspeed-socinfo.o
>    +
>    +CONTEXT_ANALYSIS_aspeed-lpc-snoop.o    :=3D y
>    diff --git a/drivers/soc/aspeed/aspeed-lpc-snoop.c
> b/drivers/soc/aspeed/aspeed-lpc-snoop.c
>    index 9165a543a250..7fa1a345acac 100644
>    --- a/drivers/soc/aspeed/aspeed-lpc-snoop.c
>    +++ b/drivers/soc/aspeed/aspeed-lpc-snoop.c
>    @@ -75,8 +75,8 @@ struct aspeed_lpc_snoop_channel_cfg {
>     struct aspeed_lpc_snoop_channel {
>            const struct aspeed_lpc_snoop_channel_cfg *cfg;
>            bool enabled;
>    -       spinlock_t              lock;    /* serialises @fifo: irq
> producer vs reader */
>    -       struct kfifo            fifo;
>    +       spinlock_t              lock;
>    +       struct kfifo            fifo __guarded_by(&lock);
>            wait_queue_head_t       wq;
>            struct miscdevice       miscdev;
>     };
>    @@ -161,9 +161,9 @@ static const struct file_operations snoop_fops =3D=
 {
>     /* Save a byte to a FIFO and discard the oldest byte if FIFO is full =
*/
>     static void put_fifo_with_discard(struct aspeed_lpc_snoop_channel
> *chan, u8 val)
>     {
>    -       if (!kfifo_initialized(&chan->fifo))
>    -               return;
>            scoped_guard(spinlock, &chan->lock) {
>    +               if (!kfifo_initialized(&chan->fifo))
>    +                       return;
>                    if (kfifo_is_full(&chan->fifo))
>                            kfifo_skip(&chan->fifo);
>                    kfifo_put(&chan->fifo, val);
>    @@ -240,7 +240,6 @@ static int aspeed_lpc_enable_snoop(struct device
> *dev,
>                    return -EBUSY;
>
>            init_waitqueue_head(&channel->wq);
>    -       spin_lock_init(&channel->lock);
>
>            channel->cfg =3D cfg;
>            channel->miscdev.minor =3D MISC_DYNAMIC_MINOR;
>    @@ -252,9 +251,11 @@ static int aspeed_lpc_enable_snoop(struct device
> *dev,
>            if (!channel->miscdev.name)
>                    return -ENOMEM;
>
>    -       rc =3D kfifo_alloc(&channel->fifo, SNOOP_FIFO_SIZE, GFP_KERNEL=
);
>    -       if (rc)
>    -               return rc;
>    +       scoped_guard(spinlock_init, &channel->lock) {
>    +               rc =3D kfifo_alloc(&channel->fifo, SNOOP_FIFO_SIZE,
> GFP_KERNEL);
>    +               if (rc)
>    +                       return rc;
>    +       }
>
>            rc =3D misc_register(&channel->miscdev);
>            if (rc)
>
> I prefer that we add the annotation as the compiler analysis provides
> some comfort in contrast to the comment.
>
> Otherwise, the rest of the fix seems okay to me.
>
> Andrew
>
> >       wait_queue_head_t       wq;
> >       struct miscdevice       miscdev;
> > @@ -114,6 +116,7 @@ static ssize_t snoop_file_read(struct file *file,
> char __user *buffer,
> >                               size_t count, loff_t *ppos)
> >  {
> >       struct aspeed_lpc_snoop_channel *chan =3D snoop_file_to_chan(file=
);
> > +     u8 *buf __free(kfree) =3D NULL;
> >       unsigned int copied;
> >       int ret =3D 0;
> >
> > @@ -125,9 +128,16 @@ static ssize_t snoop_file_read(struct file *file,
> char __user *buffer,
> >               if (ret =3D=3D -ERESTARTSYS)
> >                       return -EINTR;
> >       }
> > -     ret =3D kfifo_to_user(&chan->fifo, buffer, count, &copied);
> > -     if (ret)
> > -             return ret;
> > +
> > +     count =3D min_t(size_t, count, SNOOP_FIFO_SIZE);
> > +
> > +     buf =3D kmalloc(count, GFP_KERNEL);
> > +     if (!buf)
> > +             return -ENOMEM;
> > +
> > +     copied =3D kfifo_out_spinlocked(&chan->fifo, buf, count,
> &chan->lock);
> > +     if (copied && copy_to_user(buffer, buf, copied))
> > +             return -EFAULT;
> >
> >       return copied;
> >  }
> > @@ -153,9 +163,11 @@ static void put_fifo_with_discard(struct
> aspeed_lpc_snoop_channel *chan, u8 val)
> >  {
> >       if (!kfifo_initialized(&chan->fifo))
> >               return;
> > -     if (kfifo_is_full(&chan->fifo))
> > -             kfifo_skip(&chan->fifo);
> > -     kfifo_put(&chan->fifo, val);
> > +     scoped_guard(spinlock, &chan->lock) {
> > +             if (kfifo_is_full(&chan->fifo))
> > +                     kfifo_skip(&chan->fifo);
> > +             kfifo_put(&chan->fifo, val);
> > +     }
> >       wake_up_interruptible(&chan->wq);
> >  }
> >
> > @@ -228,6 +240,7 @@ static int aspeed_lpc_enable_snoop(struct device
> *dev,
> >               return -EBUSY;
> >
> >       init_waitqueue_head(&channel->wq);
> > +     spin_lock_init(&channel->lock);
> >
> >       channel->cfg =3D cfg;
> >       channel->miscdev.minor =3D MISC_DYNAMIC_MINOR;
>

--00000000000000f1480653fdbbdd
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Thanks Andrew. The __guarded_by annotation and context ana=
lysis integration look good, I wasn&#39;t aware of that infrastructure.<br>=
Thanks for applying those changes on top.<div><br></div><div>Karthikeyan</d=
iv></div><br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"l=
tr" class=3D"gmail_attr">On Thu, Jun 11, 2026 at 8:20=E2=80=AFAM Andrew Jef=
fery &lt;<a href=3D"mailto:andrew@codeconstruct.com.au">andrew@codeconstruc=
t.com.au</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D=
"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-le=
ft:1ex">Hi Karthikeyan,<br>
<br>
On Wed, 2026-06-10 at 17:23 +0000, Karthikeyan KS wrote:<br>
&gt; put_fifo_with_discard() acts as both producer and consumer on the kfif=
o:<br>
&gt; it calls kfifo_skip() (advances out) and kfifo_put() (advances in) fro=
m<br>
&gt; the IRQ handler without synchronizing with snoop_file_read(), which al=
so<br>
&gt; consumes via kfifo_to_user(). On SMP systems this concurrent access ca=
n<br>
&gt; leave (in - out) larger than the ring buffer, so __kfifo_to_user()&#39=
;s clamp<br>
&gt; to (in - out) is ineffective and kfifo_copy_to_user() can attempt a<br=
>
&gt; copy_to_user() past the kmalloc-2k backing store:<br>
&gt; <br>
&gt; =C2=A0 usercopy: Kernel memory exposure attempt detected from SLUB obj=
ect<br>
&gt; =C2=A0 &#39;kmalloc-2k&#39; (offset 0, size 2049)!<br>
&gt; =C2=A0 kernel BUG at mm/usercopy.c!<br>
&gt; =C2=A0 Call trace:<br>
&gt; =C2=A0=C2=A0 usercopy_abort<br>
&gt; =C2=A0=C2=A0 __check_heap_object<br>
&gt; =C2=A0=C2=A0 __check_object_size<br>
&gt; =C2=A0=C2=A0 kfifo_copy_to_user<br>
&gt; =C2=A0=C2=A0 __kfifo_to_user<br>
&gt; =C2=A0=C2=A0 snoop_file_read<br>
&gt; =C2=A0=C2=A0 vfs_read<br>
&gt; <br>
&gt; Serialize kfifo access with a per-channel spinlock. The reader drains<=
br>
&gt; into a bounce buffer under the lock with kfifo_out_spinlocked() and th=
en<br>
&gt; copies to userspace after dropping it, since copy_to_user() may sleep =
on<br>
&gt; a page fault.<br>
&gt; <br>
&gt; Fixes: 3772e5da4454 (&quot;drivers/misc: Aspeed LPC snoop output using=
 misc chardev&quot;)<br>
&gt; Cc: <a href=3D"mailto:stable@vger.kernel.org" target=3D"_blank">stable=
@vger.kernel.org</a><br>
&gt; Signed-off-by: Karthikeyan KS &lt;<a href=3D"mailto:karthiproffesional=
@gmail.com" target=3D"_blank">karthiproffesional@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt; Andrew,<br>
&gt; <br>
&gt; Thanks for the review.<br>
&gt; <br>
&gt; Changes since v4:<br>
&gt; - Use __free(kfree) for automatic cleanup<br>
&gt; - Allocate clamped count instead of full SNOOP_FIFO_SIZE<br>
&gt; - Use kfifo_out_spinlocked() in snoop_file_read<br>
&gt; - Use scoped_guard(spinlock) in put_fifo_with_discard<br>
&gt; <br>
&gt; =C2=A0drivers/soc/aspeed/aspeed-lpc-snoop.c | 25 +++++++++++++++++++--=
----<br>
&gt; =C2=A01 file changed, 19 insertions(+), 6 deletions(-)<br>
&gt; <br>
&gt; diff --git a/drivers/soc/aspeed/aspeed-lpc-snoop.c b/drivers/soc/aspee=
d/aspeed-lpc-snoop.c<br>
&gt; index b03310c0830d..c9c87a794228 100644<br>
&gt; --- a/drivers/soc/aspeed/aspeed-lpc-snoop.c<br>
&gt; +++ b/drivers/soc/aspeed/aspeed-lpc-snoop.c<br>
&gt; @@ -11,6 +11,7 @@<br>
&gt; =C2=A0 */<br>
&gt; =C2=A0<br>
&gt; =C2=A0#include &lt;linux/bitops.h&gt;<br>
&gt; +#include &lt;linux/cleanup.h&gt;<br>
&gt; =C2=A0#include &lt;linux/clk.h&gt;<br>
&gt; =C2=A0#include &lt;linux/dev_printk.h&gt;<br>
&gt; =C2=A0#include &lt;linux/interrupt.h&gt;<br>
&gt; @@ -74,6 +75,7 @@ struct aspeed_lpc_snoop_channel_cfg {<br>
&gt; =C2=A0struct aspeed_lpc_snoop_channel {<br>
&gt; =C2=A0=C2=A0 =C2=A0 =C2=A0const struct aspeed_lpc_snoop_channel_cfg *c=
fg;<br>
&gt; =C2=A0=C2=A0 =C2=A0 =C2=A0bool enabled;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0spinlock_t=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 lock;=C2=A0=C2=A0=C2=A0 /* serialises @fifo: irq producer vs rea=
der */<br>
<br>
I&#39;d prefer we avoid trailing comments, which it seems you&#39;ve added =
this<br>
time around. Since you did that ...<br>
<br>
&gt; =C2=A0=C2=A0 =C2=A0 =C2=A0struct kfifo=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 fifo;<br>
<br>
... in this specific case we can improve on the comment, with:<br>
<br>
=C2=A0 =C2=A0struct kfifo fifo __guarded_by(&amp;lock);<br>
<br>
More details here:<br>
<br>
=C2=A0 =C2=A0<a href=3D"https://docs.kernel.org/dev-tools/context-analysis.=
html" rel=3D"noreferrer" target=3D"_blank">https://docs.kernel.org/dev-tool=
s/context-analysis.html</a><br>
<br>
Adding a change along these lines currently produces:<br>
<br>
=C2=A0 =C2=A0../drivers/soc/aspeed/aspeed-lpc-snoop.c:164:32: warning: read=
ing variable &#39;fifo&#39; requires holding spinlock &#39;&amp;aspeed_lpc_=
snoop_channel::lock&#39; [-Wthread-safety-analysis]<br>
=C2=A0 =C2=A0 =C2=A0164 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!kfifo_initi=
alized(&amp;chan-&gt;fifo))<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0^<br>
<br>
I ended up applying this on top of your patch:<br>
<br>
=C2=A0 =C2=A0diff --git a/drivers/soc/aspeed/Makefile b/drivers/soc/aspeed/=
Makefile<br>
=C2=A0 =C2=A0index b35d74592964..9cba7be8c395 100644<br>
=C2=A0 =C2=A0--- a/drivers/soc/aspeed/Makefile<br>
=C2=A0 =C2=A0+++ b/drivers/soc/aspeed/Makefile<br>
=C2=A0 =C2=A0@@ -4,3 +4,5 @@ obj-$(CONFIG_ASPEED_LPC_SNOOP)=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 +=3D aspeed-lpc-snoop.o<br>
=C2=A0 =C2=A0 obj-$(CONFIG_ASPEED_UART_ROUTING)=C2=A0 =C2=A0 =C2=A0 +=3D as=
peed-uart-routing.o<br>
=C2=A0 =C2=A0 obj-$(CONFIG_ASPEED_P2A_CTRL)=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 +=3D aspeed-p2a-ctrl.o<br>
=C2=A0 =C2=A0 obj-$(CONFIG_ASPEED_SOCINFO)=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0+=3D aspeed-socinfo.o<br>
=C2=A0 =C2=A0+<br>
=C2=A0 =C2=A0+CONTEXT_ANALYSIS_aspeed-lpc-snoop.o=C2=A0 =C2=A0 :=3D y<br>
=C2=A0 =C2=A0diff --git a/drivers/soc/aspeed/aspeed-lpc-snoop.c b/drivers/s=
oc/aspeed/aspeed-lpc-snoop.c<br>
=C2=A0 =C2=A0index 9165a543a250..7fa1a345acac 100644<br>
=C2=A0 =C2=A0--- a/drivers/soc/aspeed/aspeed-lpc-snoop.c<br>
=C2=A0 =C2=A0+++ b/drivers/soc/aspeed/aspeed-lpc-snoop.c<br>
=C2=A0 =C2=A0@@ -75,8 +75,8 @@ struct aspeed_lpc_snoop_channel_cfg {<br>
=C2=A0 =C2=A0 struct aspeed_lpc_snoop_channel {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const struct aspeed_lpc_snoop_chan=
nel_cfg *cfg;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bool enabled;<br>
=C2=A0 =C2=A0-=C2=A0 =C2=A0 =C2=A0 =C2=A0spinlock_t=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 lock;=C2=A0 =C2=A0 /* serialises @fifo: irq produc=
er vs reader */<br>
=C2=A0 =C2=A0-=C2=A0 =C2=A0 =C2=A0 =C2=A0struct kfifo=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 fifo;<br>
=C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0spinlock_t=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 lock;<br>
=C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct kfifo=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 fifo __guarded_by(&amp;lock);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0wait_queue_head_t=C2=A0 =C2=A0 =C2=
=A0 =C2=A0wq;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct miscdevice=C2=A0 =C2=A0 =C2=
=A0 =C2=A0miscdev;<br>
=C2=A0 =C2=A0 };<br>
=C2=A0 =C2=A0@@ -161,9 +161,9 @@ static const struct file_operations snoop_=
fops =3D {<br>
=C2=A0 =C2=A0 /* Save a byte to a FIFO and discard the oldest byte if FIFO =
is full */<br>
=C2=A0 =C2=A0 static void put_fifo_with_discard(struct aspeed_lpc_snoop_cha=
nnel *chan, u8 val)<br>
=C2=A0 =C2=A0 {<br>
=C2=A0 =C2=A0-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!kfifo_initialized(&amp;chan-&=
gt;fifo))<br>
=C2=A0 =C2=A0-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return=
;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0scoped_guard(spinlock, &amp;chan-&=
gt;lock) {<br>
=C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!k=
fifo_initialized(&amp;chan-&gt;fifo))<br>
=C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (kf=
ifo_is_full(&amp;chan-&gt;fifo))<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0kfifo_skip(&amp;chan-&gt;fifo);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0kfifo_=
put(&amp;chan-&gt;fifo, val);<br>
=C2=A0 =C2=A0@@ -240,7 +240,6 @@ static int aspeed_lpc_enable_snoop(struct =
device *dev,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return=
 -EBUSY;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0init_waitqueue_head(&amp;channel-&=
gt;wq);<br>
=C2=A0 =C2=A0-=C2=A0 =C2=A0 =C2=A0 =C2=A0spin_lock_init(&amp;channel-&gt;lo=
ck);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0channel-&gt;cfg =3D cfg;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0channel-&gt;miscdev.minor =3D MISC=
_DYNAMIC_MINOR;<br>
=C2=A0 =C2=A0@@ -252,9 +251,11 @@ static int aspeed_lpc_enable_snoop(struct=
 device *dev,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!channel-&gt;<a href=3D"http:/=
/miscdev.name" rel=3D"noreferrer" target=3D"_blank">miscdev.name</a>)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return=
 -ENOMEM;<br>
<br>
=C2=A0 =C2=A0-=C2=A0 =C2=A0 =C2=A0 =C2=A0rc =3D kfifo_alloc(&amp;channel-&g=
t;fifo, SNOOP_FIFO_SIZE, GFP_KERNEL);<br>
=C2=A0 =C2=A0-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (rc)<br>
=C2=A0 =C2=A0-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return=
 rc;<br>
=C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0scoped_guard(spinlock_init, &amp;c=
hannel-&gt;lock) {<br>
=C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rc =3D=
 kfifo_alloc(&amp;channel-&gt;fifo, SNOOP_FIFO_SIZE, GFP_KERNEL);<br>
=C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (rc=
)<br>
=C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0return rc;<br>
=C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rc =3D misc_register(&amp;channel-=
&gt;miscdev);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (rc)<br>
<br>
I prefer that we add the annotation as the compiler analysis provides<br>
some comfort in contrast to the comment.<br>
<br>
Otherwise, the rest of the fix seems okay to me.<br>
<br>
Andrew<br>
<br>
&gt; =C2=A0=C2=A0 =C2=A0 =C2=A0wait_queue_head_t=C2=A0 =C2=A0 =C2=A0 =C2=A0=
wq;<br>
&gt; =C2=A0=C2=A0 =C2=A0 =C2=A0struct miscdevice=C2=A0 =C2=A0 =C2=A0 =C2=A0=
miscdev;<br>
&gt; @@ -114,6 +116,7 @@ static ssize_t snoop_file_read(struct file *file, =
char __user *buffer,<br>
&gt; =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0size_t count, loff_t *ppos)<br>
&gt; =C2=A0{<br>
&gt; =C2=A0=C2=A0 =C2=A0 =C2=A0struct aspeed_lpc_snoop_channel *chan =3D sn=
oop_file_to_chan(file);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0u8 *buf __free(kfree) =3D NULL;<br>
&gt; =C2=A0=C2=A0 =C2=A0 =C2=A0unsigned int copied;<br>
&gt; =C2=A0=C2=A0 =C2=A0 =C2=A0int ret =3D 0;<br>
&gt; =C2=A0<br>
&gt; @@ -125,9 +128,16 @@ static ssize_t snoop_file_read(struct file *file,=
 char __user *buffer,<br>
&gt; =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret =3D=3D -=
ERESTARTSYS)<br>
&gt; =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0return -EINTR;<br>
&gt; =C2=A0=C2=A0 =C2=A0 =C2=A0}<br>
&gt; -=C2=A0 =C2=A0 =C2=A0ret =3D kfifo_to_user(&amp;chan-&gt;fifo, buffer,=
 count, &amp;copied);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0if (ret)<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0count =3D min_t(size_t, count, SNOOP_FIFO_SIZE);<=
br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0buf =3D kmalloc(count, GFP_KERNEL);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (!buf)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -ENOMEM;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0copied =3D kfifo_out_spinlocked(&amp;chan-&gt;fif=
o, buf, count, &amp;chan-&gt;lock);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (copied &amp;&amp; copy_to_user(buffer, buf, c=
opied))<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EFAULT;<br>
&gt; =C2=A0<br>
&gt; =C2=A0=C2=A0 =C2=A0 =C2=A0return copied;<br>
&gt; =C2=A0}<br>
&gt; @@ -153,9 +163,11 @@ static void put_fifo_with_discard(struct aspeed_l=
pc_snoop_channel *chan, u8 val)<br>
&gt; =C2=A0{<br>
&gt; =C2=A0=C2=A0 =C2=A0 =C2=A0if (!kfifo_initialized(&amp;chan-&gt;fifo))<=
br>
&gt; =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0if (kfifo_is_full(&amp;chan-&gt;fifo))<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0kfifo_skip(&amp;chan-=
&gt;fifo);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0kfifo_put(&amp;chan-&gt;fifo, val);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0scoped_guard(spinlock, &amp;chan-&gt;lock) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (kfifo_is_full(&am=
p;chan-&gt;fifo))<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0kfifo_skip(&amp;chan-&gt;fifo);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0kfifo_put(&amp;chan-&=
gt;fifo, val);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; =C2=A0=C2=A0 =C2=A0 =C2=A0wake_up_interruptible(&amp;chan-&gt;wq);<br>
&gt; =C2=A0}<br>
&gt; =C2=A0<br>
&gt; @@ -228,6 +240,7 @@ static int aspeed_lpc_enable_snoop(struct device *=
dev,<br>
&gt; =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EBUSY;<b=
r>
&gt; =C2=A0<br>
&gt; =C2=A0=C2=A0 =C2=A0 =C2=A0init_waitqueue_head(&amp;channel-&gt;wq);<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0spin_lock_init(&amp;channel-&gt;lock);<br>
&gt; =C2=A0<br>
&gt; =C2=A0=C2=A0 =C2=A0 =C2=A0channel-&gt;cfg =3D cfg;<br>
&gt; =C2=A0=C2=A0 =C2=A0 =C2=A0channel-&gt;miscdev.minor =3D MISC_DYNAMIC_M=
INOR;<br>
</blockquote></div>

--00000000000000f1480653fdbbdd--

