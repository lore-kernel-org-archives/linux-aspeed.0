Return-Path: <linux-aspeed+bounces-863-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77518C19F2E
	for <linux-aspeed@archiver.kernel.org>; Thu, 27 Feb 2025 16:31:34 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Z3cKx0s64z3bnK;
	Fri, 28 Feb 2025 03:31:33 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::133"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1740673893;
	cv=none; b=Oa/t3KfIGcbBoQTxJ+OC4jLSEIr9CAooxxkOnUV0pHken6QtbyuyWJhVCaXS+3shWwQqPiSqyWPqmARdbm7S+FIgWrAguaR84BGaMFCNH5/Qh0Gxo+ascwYLSsQtfRp53XgTwUeEQn73riDQLO4ZUfW4avo2+zrLs6lIancb4Fccs88GLheI2/wNJ0RrWAiIvVlwhnn8hZaSSVLlF8He7PeO39wITVVk+rAKAV5gd9TsVtXblNpqY2G2IiD5hMW8mtV2gEQtU1QFttIZ2ppOfgzxjfZZBaAZX/IOMzJuEvozLmyaEmf4DfGfuh+/9l+zFetGLVXKURwRfQxAkqWhNA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1740673893; c=relaxed/relaxed;
	bh=9GeYTXENMr3flP3ciwo2GiPqCMR91G8nXsrWmZtyddE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lh9XT9ig9SD/uUIwllaEQEdHco5+D1bx2CLOh1zKHiVoMePxD1KstLXhKY1OkRSIGx3ELiwrB0Gl94il6x6vmba4Z9EF4k87JfzI1MzbGWUquiGlpMU+c9tjlQu3PUOBJsXXB8zZQ3+coRzyhC+HbSWrLAcYgP8yMIkEWpgTiaTepeveYtadCqw5nQF+rBV6eaJ4SeoEePqj1bG1HvC2YnfxHWD22H5NRa2scINR41xId2f+1wWKCQg1m+j3WuOh1p64XCRj7ug0UlBKpcx8+EmkYYhtvlZPKR79zdoCBFXGF3DsIcgGlXZTBaf/7Qc86TiFEr3e8L+y4S2gZ0ur1Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=minyard.net; dkim=pass (2048-bit key; unprotected) header.d=minyard-net.20230601.gappssmtp.com header.i=@minyard-net.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=oVdmtycr; dkim-atps=neutral; spf=none (client-ip=2a00:1450:4864:20::133; helo=mail-lf1-x133.google.com; envelope-from=corey@minyard.net; receiver=lists.ozlabs.org) smtp.mailfrom=minyard.net
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=minyard.net
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=minyard-net.20230601.gappssmtp.com header.i=@minyard-net.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=oVdmtycr;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=minyard.net (client-ip=2a00:1450:4864:20::133; helo=mail-lf1-x133.google.com; envelope-from=corey@minyard.net; receiver=lists.ozlabs.org)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Z3cKv2zqKz2ygR
	for <linux-aspeed@lists.ozlabs.org>; Fri, 28 Feb 2025 03:31:30 +1100 (AEDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-54529e15643so2120962e87.1
        for <linux-aspeed@lists.ozlabs.org>; Thu, 27 Feb 2025 08:31:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=minyard-net.20230601.gappssmtp.com; s=20230601; t=1740673884; x=1741278684; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9GeYTXENMr3flP3ciwo2GiPqCMR91G8nXsrWmZtyddE=;
        b=oVdmtycrZ37NCuCHAmKjsXnZycw9atknwTTyQT6qh/Y9dtXDxFW9AhsW7YI12uLwuk
         eYb9F3aLxEkPb4aJ21J1VdEiFA9ve3LQEiAYMnRUN7NCLK1g2SvZd7jBEzB6knAuMfm4
         5uMGU0PbgX4G+v5PUwbRL1UKS5ZyrFKXgGSD8WNb2+tCiTk02uQ6Ob0dShIpcxEHruqt
         h42nkJPnpEoFu9R1CrDkjUQTakZQx299XfZ96VWDk1bzIDjR9DVdHdBIIFVsNmHo45NA
         /eJ5FTOrhV2vigEXwlc3OtmQmngB7/vxuaERqJjGoCrEcg4u4TQRUfo+ooe7vWzIgxnq
         QrAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740673884; x=1741278684;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9GeYTXENMr3flP3ciwo2GiPqCMR91G8nXsrWmZtyddE=;
        b=eQYGa67ARSryBi530U0VCnUXMpwSlO53i71fZJ67Ap5/Yy9QbjFoHzeNCWpX29+2bO
         YdWq8X3Cj+baurDRC1aVdCqLR4YI/89+tVT642QucOUwCYLYGGMC2N73wfmD5Je+sYDd
         8oe4pY2HLLkoLKcP/3HADOKG4OiK6fIAANPhT1leTuHrhd6BX7wqKUadqn2c/Lo1DOzI
         KWMAN/hxoG/dFC1dIHTczMDLBmpJdrToyR2tpIKzrsPh9fs1VDeKruzMT4mP0NchRPj5
         I7MpLn4jxwgu969v/LWZV6NvX3+zY58RLF7rJUKY7mRwWA/iTiBcVyhTa2vIAsJHiK2Q
         xQsQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/JY0ybv6pVXZhjnI/fVKRhpOgOK7R1OUocxDqiFxovVjAqhyf2KxTeHRVZ8uH0lZwIFBOm9H+ZXPKdGA=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxtmfMSYgfaIzTWZajRIimxtTWWvoz6bECaxiwI8PAS+g/U8gVa
	BWRFS4C2ILQn13wUTyeFpiK+KVZ4W9VJI4TYqnImJ5Q3VP/IOsi3oG9k3YWnZ+Sd4nJaZ3/GVDW
	HmCaL9EHqfsZjN5mz3x9LD8ZjN4RRAHMFnqX6YQ==
X-Gm-Gg: ASbGncuAZPXpXE/POA882qnF6Ke47rXXNvjNJf36LzaL1PWArZpZOWmCvSQUWs2Zqlh
	sxGl67RrkmfwZtIO0iFveRa3PqydC9h7UJ2T19r2M8fijk8W+fexLH7hvF3fUg4Ht3GWep+yZpW
	TPWn40FqutR8qU8JhylTDvmmhE5cBfMFvh2FmZcg==
X-Google-Smtp-Source: AGHT+IEUbAC3kjl5eNNXKnBI/MMkmVbVJWoGnJKM7ezHnOTqe5P7XXqY0IVO/n+TvmfZpG/9CNbmwSisZkbfQ+rFnfw=
X-Received: by 2002:a05:6512:281d:b0:545:d54:2ebf with SMTP id
 2adb3069b0e04-5494c107e76mr52906e87.3.1740673883880; Thu, 27 Feb 2025
 08:31:23 -0800 (PST)
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
References: <20250204194115.3899174-1-ninad@linux.ibm.com> <20250204194115.3899174-2-ninad@linux.ibm.com>
 <fd92f75620e48957c2875cdcfd1285c33d3176e6.camel@codeconstruct.com.au>
In-Reply-To: <fd92f75620e48957c2875cdcfd1285c33d3176e6.camel@codeconstruct.com.au>
From: Corey Minyard <corey@minyard.net>
Date: Thu, 27 Feb 2025 10:31:12 -0600
X-Gm-Features: AQ5f1JrxG1t1lSqYDcbZpYZ-TVphariQNf3aM6dUFwiyKs1tLOEBbUdBR-9V5Rs
Message-ID: <CAB9gMfqkRZY3y5V+WDyxvyrdzWNWu2gjmyEnj8mygo85hjX8sw@mail.gmail.com>
Subject: Re: [PATCH v9 1/9] dt-bindings: ipmi: Add binding for IPMB device
To: Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: Ninad Palsule <ninad@linux.ibm.com>, minyard@acm.org, andrew@lunn.ch, brgl@bgdev.pl, 
	linus.walleij@linaro.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, openipmi-developer@lists.sourceforge.net, joel@jms.id.au, 
	devicetree@vger.kernel.org, eajames@linux.ibm.com, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Oops.

Go ahead and take it through the BMC tree.

Acked-by: Corey Minyard <corey@minyard.net>

On Tue, Feb 4, 2025 at 6:01=E2=80=AFPM Andrew Jeffery
<andrew@codeconstruct.com.au> wrote:
>
> Hi Corey,
>
> On Tue, 2025-02-04 at 13:41 -0600, Ninad Palsule wrote:
> > Add device tree binding document for the IPMB device interface.
> > This device is already in use in both driver and .dts files.
> >
> > Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> > Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
> > ---
> >  .../devicetree/bindings/ipmi/ipmb-dev.yaml    | 56
> > +++++++++++++++++++
> >  1 file changed, 56 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/ipmi/ipmb-
> > dev.yaml
>
> Would you like to take this through the IPMI tree? Otherwise I'm happy
> to take it through the BMC tree with your ack.
>
> Andrew
>

