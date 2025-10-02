Return-Path: <linux-aspeed+bounces-2395-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A770CAC5BB
	for <linux-aspeed@archiver.kernel.org>; Sun,  5 Oct 2025 00:30:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cfNbQ47Wlz304h;
	Sun,  5 Oct 2025 11:30:26 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::634"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1759379043;
	cv=none; b=SmYCSVlRvoa4VHTV+wOoePY+7HExlUIt3q+akcq31GgeluM99ZTbkChcPrk7EGxjGMr4tx9b8eCE+KsDGRk+c7sGoE/y+hh252abk93SJ/NxHjSHE+Qz6aC1PczVyjUFfubc9OBHhCDLAY8jkM5TxldAIN+6Ji2nEsz/yQ/4mKTbTKl98M7DK6D7iGR+V8L2PZfjfDrb7vUhkiDIPA1AVboe8s28Cc+zwzjGp9iGQ7nUJNHpfWjlJ9YXZ2q9opx6urkcHFZcawhS7+8wByD5hQl4qGdmJu5Oh2ysa3RDGYGt/rGwYHo1rpXonVD/3oodTfXbFk92DmPqw1ycoYGRxw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1759379043; c=relaxed/relaxed;
	bh=y2QRGst729/DWiP4I9nqZ3Qxmv8ECUfQin2YGfwodis=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SMgy4XD+/sU3raecK/AM7jMwGVwfv3H+cZs9cr7sRp7mC2gRE79HTLSorYDXgaHMUFKbjQBKcBIvRuBiGCwpzbJRAfeGiVCO3hUHJpr7LyOvxKBxhx9y8YdO7biy/ISTCPwJvArCBn8+nw0xRbb+pigxW/EkflBL33+fptBAystUL6xYjPsqISIiRXVaRruQkgK9b07AIcmuGIh+JZuYjvCkCCXPEzDSXimUkVnzAiyx0SMPDg171tDCnCBE7CKQOOmryXXuegIVme4rYZHj4erB4lPDFMRiQdkOL0MNWYVrcS5OOLe+l896303TUbrM4m6sWPeWgyaXAHFtWabTCA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=cb97T6R3; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::634; helo=mail-pl1-x634.google.com; envelope-from=kevin.tung.openbmc@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=cb97T6R3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::634; helo=mail-pl1-x634.google.com; envelope-from=kevin.tung.openbmc@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ccdwL1qf0z2xMV
	for <linux-aspeed@lists.ozlabs.org>; Thu,  2 Oct 2025 14:24:01 +1000 (AEST)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-2680cf68265so3920345ad.2
        for <linux-aspeed@lists.ozlabs.org>; Wed, 01 Oct 2025 21:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759379039; x=1759983839; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y2QRGst729/DWiP4I9nqZ3Qxmv8ECUfQin2YGfwodis=;
        b=cb97T6R3JxxDBqaFPYJaFbaTG8bjWyQMUYs5CFVRd4iLqZUlgqjwR4fEgU80np1aL9
         pIlupQEV53mg7Wy3SdebMg6z8ZpngDOhlB6m9dQpMAQdFN9/R7HEQWJpm+3yExTz6WEl
         Jlmc49WuBtKXRJQt4URr3wQbijlVh6ag80z2s1JlNSoHhR5+DNxpvZ/jBx5xwHlMVdnF
         5+EUWfhgaiOb8n1DMnP5iJTEgJcFbUWlWCdojgw6CNJyAaUaSVY8yliowWhe86L+PPg3
         6j1nB/sy8XmwpmWlCGv40WFO3vMd30GryXvBtHAvj40YHZMkSQ4b3/xwKAjAjgZPOBOA
         3Ijg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759379039; x=1759983839;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y2QRGst729/DWiP4I9nqZ3Qxmv8ECUfQin2YGfwodis=;
        b=NwGBjyXr9Uq8b/5bXnlh83eYpGQPEils8IsrLZsBKEAG3k+o8Zg9efxSoqmA0I9BIs
         DRZVRqD/XorEJZtySYnpGVmWVe5+xb3XSTSySfYNXVUetpz35Tvr8JC8bN3Hlk47TC1n
         L55nEbMNZgHTutipyHuOQVwN9b/JpvIFnJFoZNOmdXKihaY7wVSXonuQoCuuaJbHeJTL
         qj3JQ2JNU3pAhPD9cby+zS/ggrDOevf/ZlJ3UnId534RS6gsqIiqJigCDXde1fN/JMYL
         tHcVoXXYHYplFY7EOU9SOT0JWFEZ1BIIhRx69Njv60BrfK0NKXD6ck3Js0f8aiJUjCs3
         h3TA==
X-Forwarded-Encrypted: i=1; AJvYcCVj1oG9Q43uT9a0dVe/4+SUwA6M1gDOiBLgdaVK1efCziLIj2FRv56FmV4pZvoGlpA19aUz6W+wAWKYM8U=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzjgMBT76+/78nPv8DXqt9QzchH5Lq6xwQWJa/MDTlbMGFhxLhw
	CkqS758XkE3oF0mQfGRsLdDYqZEshm+UvB1lXwTugjrZJ7TrIwVzCG7mwXhOXdvbZjiT1sqbzkP
	N7D3Ln6309h2SKpilu/UfAVadUKaDkGY=
X-Gm-Gg: ASbGnctZbKOzsu19P847spnX8UigsJmvuhnnkR++pHVFPhYOrCUe+zp8bjPXAez7q7h
	777wKlir51uCe51GmYiSok7LFbumIAfV9MInoz2+m0VlvCYgbaF0OaPK8rbDErMR1SUnQxTG4zs
	Uzn4Sim4fsuQEmI0EgpzScp0ZILwnxHHsk1Y3Einb7vQzQDW02ORBJ2ldJABqP8juGXjHepJ0Fe
	urdJrB4ktBEnf8WypgH5HxsIA3TFu4L
X-Google-Smtp-Source: AGHT+IHgkuju9CUwpPT0WwGqt9+xSzAjEsWxHRza/bmAnljDvo45aLWn/1dVAmMuO1OQzeCs6YLRY6uoy1Dxbms4f2k=
X-Received: by 2002:a17:903:3c2d:b0:269:8072:5bda with SMTP id
 d9443c01a7336-28e7f45aa2cmr81883465ad.54.1759379038825; Wed, 01 Oct 2025
 21:23:58 -0700 (PDT)
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
References: <20251001-yv5_add_dts-v3-0-54190fbc0785@gmail.com>
 <20251001-yv5_add_dts-v3-1-54190fbc0785@gmail.com> <20251001-bonding-surging-af8cd0d09e07@spud>
In-Reply-To: <20251001-bonding-surging-af8cd0d09e07@spud>
From: Kevin Tung <kevin.tung.openbmc@gmail.com>
Date: Thu, 2 Oct 2025 12:23:47 +0800
X-Gm-Features: AS18NWCewZBOJ3_bvPqMIiAefrcZiLRdaKPOQ3p104CWc2zI58_oYaZj_KaxEko
Message-ID: <CABh9gBcKt1zqvMQ=390HESPR5KrA42jaMFj9Ca4qmeS0d0ToAw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: arm: aspeed: add Meta Yosemite5 board
To: Conor Dooley <conor@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
	Andrew Jeffery <andrew@codeconstruct.com.au>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Magnus Damm <magnus.damm@gmail.com>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	Amithash Prasasd <amithash@meta.com>, Kevin Tung <Kevin.Tung@quantatw.com>, 
	Ken Chen <Ken.Chen@quantatw.com>, Leo Yang <Leo-Yang@quantatw.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 2, 2025 at 2:33=E2=80=AFAM Conor Dooley <conor@kernel.org> wrot=
e:
>
> On Wed, Oct 01, 2025 at 04:47:50PM +0800, Kevin Tung wrote:
> > Document the new compatibles used on Meta Yosemite5.
> >
> > Signed-off-by: Kevin Tung <kevin.tung.openbmc@gmail.com>
>
> You've repeatedly ignored my ack, so I assume you don't want it.
> Maybe you want a nak instead?
>

Apologies for ignoring your ack repeatedly, that was not intentional.
I truly value your review and will make sure to include it. Would you
suggest that I send a v4 to pick it up, or is it fine to carry it
forward in the next revision?
Thank you again for taking the time to review my patches.

Kevin
> > ---
> >  Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b=
/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
> > index 456dbf7b5ec8f4442be815284e1ad085287dc443..6f2b12f96bd6ce31b4175e1=
09a78d931dffdfe28 100644
> > --- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
> > +++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
> > @@ -89,6 +89,7 @@ properties:
> >                - facebook,minerva-cmc
> >                - facebook,santabarbara-bmc
> >                - facebook,yosemite4-bmc
> > +              - facebook,yosemite5-bmc
> >                - ibm,blueridge-bmc
> >                - ibm,everest-bmc
> >                - ibm,fuji-bmc
> >
> > --
> > 2.51.0
> >

