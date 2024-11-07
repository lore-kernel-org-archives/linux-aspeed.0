Return-Path: <linux-aspeed+bounces-95-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43056D43349
	for <linux-aspeed@archiver.kernel.org>; Thu,  7 Nov 2024 11:22:33 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Xkfn365Gsz2xYs;
	Thu,  7 Nov 2024 22:22:31 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::635"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1730978551;
	cv=none; b=hBQ5f/S9nISpvVbotsQ106e0LDjP1aA0KN/Ydx88xNyQkj6CUREOyxMzGCbJjg670xsVXYbsczuzyPj75adul/5gmv8bTTdBPIoRW1K/t9PS06Iwcsj1WhKuXKDrTO6qSuuSIhQ+ksRV5NGLqpOah0gRd2sCqudhTwT9HuxxUAMGiNxga6IOGPeeYhegGGSKjVNg3CXEPDiDo5hgTadm38ytk5ysMYMh7jDCWiyj/YXzid/tsvqom/mikagsiQygRfVfmnZVKZxeUSWOF9f2EbeoaYI7Axg4ZrsTPZiNumyBMU2npmiPxaa91DZ4SWPG1qkxpUEi3Hdfo7tczT4FAA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1730978551; c=relaxed/relaxed;
	bh=iyCDl7ZPUt6a//yr/835EBnfK0zGbZXT8k2phIEStMM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cFwGhpOsSIkZqG8VVqaXZLunSD7SNvdjipWdVOZrmKK9MO9mkByYwSuB4eaReOFH9MWmKVq7qlfWwuEzwllIZAsh/vz6+18oTV36bCrix7KjACne6yymudMrcEPV5pBd0sM/r9w0woWoz3B7bA4iJfKvuimi7s2WwOGj4EbzZHBsua5+hJWVemUO0d3Lz8/qXSMmznoce2gBVZqszTeZJv4O3+GCVYBRmHFp6zotmqvGDogavtcHKmj1ldIHoeV+AwMP21rqsZR3iYEq+jYYpWo7v+p9zK/55H570o7+7rgHoaNecdMZ84FlGfo6E0hEAGv5lklUJBuHiL1N5oArzg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=cdkBwzuq; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::635; helo=mail-ej1-x635.google.com; envelope-from=potin.lai.pt@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=cdkBwzuq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::635; helo=mail-ej1-x635.google.com; envelope-from=potin.lai.pt@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Xkfn14f5zz2xCd
	for <linux-aspeed@lists.ozlabs.org>; Thu,  7 Nov 2024 22:22:27 +1100 (AEDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-a9a628b68a7so128520666b.2
        for <linux-aspeed@lists.ozlabs.org>; Thu, 07 Nov 2024 03:22:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730978545; x=1731583345; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iyCDl7ZPUt6a//yr/835EBnfK0zGbZXT8k2phIEStMM=;
        b=cdkBwzuqm/KwAUuIVgdIDWJoYKRWiwpO3YS2u+0KOlRVl0B5qYEnQ5YCByEos1p0kg
         dVvyeHSCgBJfG0DJz+j8CgVm0Dzvs+z3+b1Ml6hmvsiCyt6Ko1xDpqM5n4JvM7kKQ+L3
         gEsLzbJ/OK8lVCBUPS28j8RmOxZp7UhwB6oSwJcfuXIv/w+z9M0NWFvO7USMbaWMMNJI
         ecsDq0xOG/ET9mXGIMpd7iSwRgyqaimhqe/c1ZRzR3MyB52oqztemIYo9uupiBumLfRy
         0m9EFUa3/jh970fnOANyxCo7DCgd6ShdAM9CY7hjssQXPyo5zMhXyIR50LlOpFPyYFug
         cUwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730978545; x=1731583345;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iyCDl7ZPUt6a//yr/835EBnfK0zGbZXT8k2phIEStMM=;
        b=wvCRxm2WLeO/JNi4DUFENRz/McdStBaG5lV8DbLUqfT4NwC9tuDATyTpdOFMlY65vd
         hZgEDNKA6DcIc9kS9pDO3J18UjDe9zTDXsY3pght5IX0s5j9lkNhbq87ggCXLAoZ/Txx
         brC+Pv+oOxOwfwwD7bAulKkJ6G4PSFVl/hvEBv8hizpt+2dw3EKrkjxFOLsfoZbvU0zO
         i3dSH6LVPx5Pr08zaNTHR6nbItcTjU3dXfJWMLnuptCi5z2KI9Oi71qNgeULjZd+LJVK
         zo4OOyhiJy1r6ZlJwgGXPeEH02w5tCj0ReWbTWO2K8W+YYv8ak1QX9HueTER+wqinnBL
         E8jQ==
X-Forwarded-Encrypted: i=1; AJvYcCWyzQxsAR4jLmH0ELgpa6eDdFH1jrw6AFzy8dDsqzhmxz4ssF9nMlXhhJBvK+4Kuly/Nl3JW15JnMu1d2Q=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwcP7fGUiiZmoI2Ow35aLusdsu+KkScepYP8AdXpKYdBtQ5lRd0
	vFcj1GgTL3CAlpUaqvJQ+LMdojUfTp81FS5vtgR7iDcULpnyxfB2lOCDjO3nSqWSXIF4f5wOogw
	bvmQ/o9mMVjXic2zc61VEcYh4dbY=
X-Google-Smtp-Source: AGHT+IHGsPapN8RHF9Qpx6NuCKBBsmhdkYBPLxie1jdxHa0MnvuH1vKs6Dy7tAmC0sQgjvTv9FyEtEoss4jejQxSaY8=
X-Received: by 2002:a17:906:8415:b0:a9e:c940:d154 with SMTP id
 a640c23a62f3a-a9ec940d1ebmr412325866b.17.1730978544331; Thu, 07 Nov 2024
 03:22:24 -0800 (PST)
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
References: <20241106-catalina-cpld-ioexp-update-v1-0-3437bcfcb608@gmail.com>
 <20241106-catalina-cpld-ioexp-update-v1-1-3437bcfcb608@gmail.com> <8e858e760c78ddf533e9e03c20b34fce29862c2e.camel@codeconstruct.com.au>
In-Reply-To: <8e858e760c78ddf533e9e03c20b34fce29862c2e.camel@codeconstruct.com.au>
From: Potin Lai <potin.lai.pt@gmail.com>
Date: Thu, 7 Nov 2024 19:22:13 +0800
Message-ID: <CAGfYmwVxwaZk-si1OkP4xeaODhAO74Hv43U=SpzOsGOBkTH8Bw@mail.gmail.com>
Subject: Re: [PATCH 1/2] ARM: dts: aspeed: catalina: update pdb board cpld
 ioexp linename
To: Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
	Patrick Williams <patrick@stwcx.xyz>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, Potin Lai <potin.lai@quantatw.com>, 
	Cosmo Chou <cosmo.chou@quantatw.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 7, 2024 at 7:41=E2=80=AFAM Andrew Jeffery
<andrew@codeconstruct.com.au> wrote:
>
> On Wed, 2024-11-06 at 16:58 +0800, Potin Lai wrote:
> > Update the GPIO linename of each PDB CPLD IO expander based on latest
> > CPLD firmware.
>
> What version is the latest CPLD firmware? What was the previous version
> with the old pin assignments?

Because the hardware changes from EVT to DVT, the CPLD firmware
reallocated the IOEXP pin mapping in DVT version.
I will add more description into the commit message in the next version.

>
> I'm also interested in some discussion of the coordination between CPLD
> firmware, the devicetree and the BMC userspace configuration. This
> change feels pretty painful.

I am not from the CPLD firmware team, I only know our CPLD team was
redesigning the entire struct which causes the huge changes of IOEXP
pins.

This is probably a different topic, I am curious about is it possible
to assign the linename in userspace?
In OpenBMC, there are many services that depend on GPIO linename, it
will be more flexible if I can assign the linename before service
starts.

Thanks,
Potin

>
> Andrew

