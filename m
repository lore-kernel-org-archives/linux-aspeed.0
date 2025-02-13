Return-Path: <linux-aspeed+bounces-714-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 274CAC3DA4A
	for <linux-aspeed@archiver.kernel.org>; Thu, 13 Feb 2025 22:01:21 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Yv8Jv3Nh3z30Ff;
	Fri, 14 Feb 2025 09:01:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::633"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1739411464;
	cv=none; b=W3+0YmvuzsYlXgw8PsdjFVGcMw7bDKCqyaZAvYe9naH2gJXYxGHQgpq56ltc/3wrZSulg69WocgFwgWaxv/R6OkzoaYfOTSWMcRC60vIkjRMQVLWlu3+PV+dW0sCMYWQ0U0pSlvRzTMnjeoCm2etAWcbqZAMoaumgu8orL+QBDrEYsXD9tSh0shcf7Cejaic1ouaNjkz9mbGPt8ij6vxwNsTF3FYAB6HW9H6l7T7HzsRe/m8R4s+IR7CVfui5W4wzXn2NIr0LgMU38m2xExj9OwUbLXdvJY+TWolZ9KVoaMD0Utgk4rrrZ7hFflvcNk4nVd6PRhk6jrk1elstktOKw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1739411464; c=relaxed/relaxed;
	bh=nF+3d9YE5wll/jDVUEdSENnWO/Lio/88ULs9I5MUpd8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A0RnjLiaa5llcqFqDSIwJMCeLzeJ6Oru6irwxaGHbuo9L7YNII9UBIRmcL+PJhwhx98O+SKX+HB6V9H2Xf6YPNVHnkXK2vYBtRdXomHzfWMqfCZ7Lhc6kXUluEI+CWwr+002qKgWKctgGYuDK45wgXxXhWbQZYFFeFDCG/JAb76qzowoIeyoYsT6S4V5EBmNtZQuuikjrbtbDzU0+ZUEwiV1ygI7eWRj0tcXTlsT7QeBkzCBjRW3pw7S8ttfIrlYs7660ZTm5WHbVtd8fUEwfvl7eYxoTzWp0Z4cvYAGgW/UQUMalnB4XkWV0kyRuAG5Mf7FbUIDsH9C+YpwanOnAg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=K5KXVhY6; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::633; helo=mail-pl1-x633.google.com; envelope-from=chenyuan0y@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=K5KXVhY6;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::633; helo=mail-pl1-x633.google.com; envelope-from=chenyuan0y@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YtdSR6P5Mz2yK7
	for <linux-aspeed@lists.ozlabs.org>; Thu, 13 Feb 2025 12:51:02 +1100 (AEDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-218c8ac69faso567685ad.3
        for <linux-aspeed@lists.ozlabs.org>; Wed, 12 Feb 2025 17:51:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739411461; x=1740016261; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nF+3d9YE5wll/jDVUEdSENnWO/Lio/88ULs9I5MUpd8=;
        b=K5KXVhY6jXSMlWa4uJoVQP7tSvixO8J7vsu2Hj3KAPmT9oUcuKjRTCoMixvpe6l7xN
         5z40n6eNjGGBSi8Ki/gdWnNNdIjW7ND+5tKkZLmkXhfZNkdtPJQj+wTf8qTwLbtXHvrA
         Ynzs2jNAgSG5VmrN7o6JcY69u87r6wHB+matXAodmRLKVVzBZFQI1/vOloUljnXSfWSn
         KfQb8L+qYbpishKjxk0t5bIs/bn1XzkPY7nF88jvJyz71DNFAzTD9AHQVk9tH8FfXG14
         TKZoUNMFEbvH5C2xwAX8azxOEHhOOwplsZ4+4cRzEKkU32FEHQ+93loUSoDUTQwCIVRW
         VyBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739411461; x=1740016261;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nF+3d9YE5wll/jDVUEdSENnWO/Lio/88ULs9I5MUpd8=;
        b=GMA5zFzgOIcNH01UH3SPWy0hvnQvvlmLbEhC71N7P0/EyT2jsTxJOuptlqJYqS+dPv
         m/EdSFskgn6Is65sTk2rCuLikkhJZF5ordiM1jI8NcvUo7cH4sJfSTBByT1cZvoEZJka
         gdgMqjh+64WUxxTirGExGJq4GybhNmcDIWYpfnRxcKBiwvqzAhO3ctIOsWgwpcMsBwge
         Z5iIJJ0Xs0P4ZDcJcojSWV3Sk2OnpxvqjzJqAU8YN8UybEjDYsEiO5q+HDVaNJkqB813
         DFVkzEeZzSvKyEdmmm/O4RrqL7secduKPDaTT68LN5IIO0WaEUxTLWE8K9qdK+vg4iNo
         ghZg==
X-Forwarded-Encrypted: i=1; AJvYcCVA6NC79b3BlsUO39xHC/Qbmeg0rAMcl0viWK3z0Pui+ZuEX9zNDhlqGsNYiFlg7aRvg92GppFT2IzGS+4=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyUPe+FPZILVe+9ZYIiY+HDLk0UOMBM7EpuQQ999RXQFoupH7GF
	YHKIwXIlkzGb66TMwCyDyQSqiVMZBIjKJNDSHylDHGx4xZWL3+tHQn+r+BpsG3Ayx0aDscDy1sU
	jQTjCEAMeyF3nDQdwz42SGdc3iA==
X-Gm-Gg: ASbGnctF9ax4NicfXNnr9oAMurR1UIRX6U8drLUOgxUGizefdlyNr3oHwb0rtwW2HFO
	A6rAAh4DVZWkhMacfS+JMonOV1egLny3ITVJyQpU8FLeHKZjzzgBFQLK1UB4OWDCbeS8mzNboUg
	==
X-Google-Smtp-Source: AGHT+IFMzUNH4nx8Yt+NdViQ9eOLs4WezIKfW1Xnu9XXaeSGgUXoUd6cnTuTro+aX0pUCtSkVo5z0Ezs9Q5zdCPaPVI=
X-Received: by 2002:a17:902:ea02:b0:215:3862:603a with SMTP id
 d9443c01a7336-220bbb465f2mr34801125ad.10.1739411460841; Wed, 12 Feb 2025
 17:51:00 -0800 (PST)
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
MIME-Version: 1.0
References: <20250212212556.2667-1-chenyuan0y@gmail.com> <f649fc0f8491ab666b3c10f74e3dc18da6c20f0a.camel@codeconstruct.com.au>
 <CALGdzuoeYesmdRBG_QPW_rkFcX7v=0hsDr0iX3u5extEL5qYag@mail.gmail.com> <8e6c7913fda39baa50309886f9f945864301660f.camel@codeconstruct.com.au>
In-Reply-To: <8e6c7913fda39baa50309886f9f945864301660f.camel@codeconstruct.com.au>
From: Chenyuan Yang <chenyuan0y@gmail.com>
Date: Wed, 12 Feb 2025 19:50:49 -0600
X-Gm-Features: AWEUYZkVYD9t8ecpGjfaGqr6TdWOTef7hnfeghSVidusmxHZlhnX0dA023zCsj4
Message-ID: <CALGdzurifZaqatjGRZGxA4FyNBHOYJdVXpKHSM4hQdA3qZtYvQ@mail.gmail.com>
Subject: Re: [PATCH] soc: aspeed: Add NULL pointer check in aspeed_lpc_enable_snoop()
To: Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: joel@jms.id.au, richardcochran@gmail.com, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

I've drafted the following patch to address the resource cleanup issue:

```
 drivers/soc/aspeed/aspeed-lpc-snoop.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/aspeed/aspeed-lpc-snoop.c
b/drivers/soc/aspeed/aspeed-lpc-snoop.c
index 9ab5ba9cf1d6..4988144aba88 100644
--- a/drivers/soc/aspeed/aspeed-lpc-snoop.c
+++ b/drivers/soc/aspeed/aspeed-lpc-snoop.c
@@ -200,11 +200,15 @@ static int aspeed_lpc_enable_snoop(struct
aspeed_lpc_snoop *lpc_snoop,
  lpc_snoop->chan[channel].miscdev.minor =3D MISC_DYNAMIC_MINOR;
  lpc_snoop->chan[channel].miscdev.name =3D
  devm_kasprintf(dev, GFP_KERNEL, "%s%d", DEVICE_NAME, channel);
+ if (!lpc_snoop->chan[channel].miscdev.name) {
+ rc =3D -ENOMEM;
+ goto free_fifo;
+ }
  lpc_snoop->chan[channel].miscdev.fops =3D &snoop_fops;
  lpc_snoop->chan[channel].miscdev.parent =3D dev;
  rc =3D misc_register(&lpc_snoop->chan[channel].miscdev);
  if (rc)
- return rc;
+ goto free_name;

  /* Enable LPC snoop channel at requested port */
  switch (channel) {
@@ -221,7 +225,8 @@ static int aspeed_lpc_enable_snoop(struct
aspeed_lpc_snoop *lpc_snoop,
  hicrb_en =3D HICRB_ENSNP1D;
  break;
  default:
- return -EINVAL;
+ rc =3D -EINVAL;
+ goto free_misc;
  }

  regmap_update_bits(lpc_snoop->regmap, HICR5, hicr5_en, hicr5_en);
@@ -232,6 +237,14 @@ static int aspeed_lpc_enable_snoop(struct
aspeed_lpc_snoop *lpc_snoop,
  hicrb_en, hicrb_en);

  return rc;
+
+free_misc:
+ misc_deregister(&lpc_snoop->chan[channel].miscdev);
+free_name:
+ kfree(lpc_snoop->chan[channel].miscdev.name);
+free_fifo:
+ kfifo_free(&lpc_snoop->chan[channel].fifo);
+ return rc;
 }
```

I have a couple of questions regarding the cleanup order:

1. Do we need to call misc_deregister() in this case, considering that
the registration happens before return -EINVAL?
2. If misc_deregister() is required, is there a specific order we
should follow when calling misc_deregister() and
kfree(lpc_snoop->chan[channel].miscdev.name);?

-Chenyuan

On Wed, Feb 12, 2025 at 7:39=E2=80=AFPM Andrew Jeffery
<andrew@codeconstruct.com.au> wrote:
>
> On Wed, 2025-02-12 at 19:37 -0600, Chenyuan Yang wrote:
> > Hi Andrew,
> >
> > Thanks for your prompt reply!
> >
> > On Wed, Feb 12, 2025 at 6:21=E2=80=AFPM Andrew Jeffery
> > <andrew@codeconstruct.com.au> wrote:
> > >
> > > Hi Chenyuan,
> > >
> > > On Wed, 2025-02-12 at 15:25 -0600, Chenyuan Yang wrote:
> > > > lpc_snoop->chan[channel].miscdev.name could be NULL, thus,
> > > > a pointer check is added to prevent potential NULL pointer
> > > > dereference.
> > > > This is similar to the fix in commit 3027e7b15b02
> > > > ("ice: FiI am cx some null pointer dereference issues in ice_ptp.c"=
).
> > > >
> > > > This issue is found by our static analysis tool.
> > > >
> > > > Signed-off-by: Chenyuan Yang <chenyuan0y@gmail.com>
> > > > ---
> > > >  drivers/soc/aspeed/aspeed-lpc-snoop.c | 2 ++
> > > >  1 file changed, 2 insertions(+)
> > > >
> > > > diff --git a/drivers/soc/aspeed/aspeed-lpc-snoop.c
> > > > b/drivers/soc/aspeed/aspeed-lpc-snoop.c
> > > > index 9ab5ba9cf1d6..376b3a910797 100644
> > > > --- a/drivers/soc/aspeed/aspeed-lpc-snoop.c
> > > > +++ b/drivers/soc/aspeed/aspeed-lpc-snoop.c
> > > > @@ -200,6 +200,8 @@ static int aspeed_lpc_enable_snoop(struct
> > > > aspeed_lpc_snoop *lpc_snoop,
> > > >         lpc_snoop->chan[channel].miscdev.minor =3D MISC_DYNAMIC_MIN=
OR;
> > > >         lpc_snoop->chan[channel].miscdev.name =3D
> > > >                 devm_kasprintf(dev, GFP_KERNEL, "%s%d", DEVICE_NAME=
,
> > > > channel);
> > > > +       if (!lpc_snoop->chan[channel].miscdev.name)
> > > > +               return -ENOMEM;
> > >
> > > This introduces yet another place where the driver leaks resources in
> > > an error path (in this case, the channel kfifo). The misc device also
> > > gets leaked later on. It would be nice to address those first so that
> > > handling this error can take the appropriate cleanup path.
> > >
> > > Andrew
> >
> > It seems that the `aspeed_lpc_enable_snoop()` function originally does
> > not have a cleanup path. For example, if `misc_register` fails, the
> > function directly returns rc without performing any cleanup.
> > Similarly, when the `channel` has its default value, the function
> > simply returns -EINVAL.
> >
> > Given this, I am wondering whether it would be a good idea to
> > introduce a cleanup path. If so, should we ensure cleanup for all
> > possible exit points?
>
> Yes please!
>
> Thanks,
>
> Andrew
>

