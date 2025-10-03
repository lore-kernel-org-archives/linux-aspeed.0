Return-Path: <linux-aspeed+bounces-2396-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09335CAC5BB
	for <linux-aspeed@archiver.kernel.org>; Sun,  5 Oct 2025 00:36:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cfNk43F4vz304h;
	Sun,  5 Oct 2025 11:36:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::42e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1759455099;
	cv=none; b=F+KDw8qIKttg7svK+GqdK+aarQLTdWprQ/uA1ui/cwf/aXmmDVdn8vi4S4lzlEJCXMeTv9Md4EtBY7McffBnXvxQ2UDQ2SnwN1opN3L5EcthIcwYU16tiNmtVU9Hj4UcL5TnvnuQNqmFoYu0oVEk2jkTmQtvsBjgdhVhrtRGu/B+Y6TTe0wGu3thQhxTmsSc6/+AB4OijRmc7QrVypK7cvfrpAh/fyq2ULy+LSJpEez+1SEpoXFgX0ko4yfTzXV4EJaRs/q1qJ/GVP7J/WBhggJTES29dE99Y2IC7vcaT+03rN3nkEjOG67Se3XcSVs9LA6ts45GlA0kPVN6Ybr0FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1759455099; c=relaxed/relaxed;
	bh=Zgov3mqg1JWQnOI+E7/IFHeQFC41StHTfUVf14re2lo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=czZ5vkMeZqbIrkHmiWSDjZkKp4hi/luGNyYUqXRWHl0ci+hJlve+fpGj1AEkwNbnzJIh8XwHsfxrebGXIaUnEM25oe1Qr4bnAGn2fQUBMu1IJjT7DEFh+yBmurJa1LwDzs9fuij/STjkdO9oJhf8jZjbRNnPytBi05BRl9WArUy7J7VfCZHU8Ae8R7x/JWa/OdEfx89M5F6KL4N/Lrxiod147gENdvGnXp66s/O9+Ry3S3PN2usmb0CoYpZfwSf9Vr79hStGvZ3NJ0cBMU6r1IlRb3PFHBZzgZHD3iHAWxcYHoUGMRr8JN3YB02t35vWhQvqoeRCB76NvwiczMl6Tg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=iwSB+ETR; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::42e; helo=mail-pf1-x42e.google.com; envelope-from=kevin.tung.openbmc@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=iwSB+ETR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::42e; helo=mail-pf1-x42e.google.com; envelope-from=kevin.tung.openbmc@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cdB2y3WMjz3cnv
	for <linux-aspeed@lists.ozlabs.org>; Fri,  3 Oct 2025 11:31:37 +1000 (AEST)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-76e4fc419a9so1722903b3a.0
        for <linux-aspeed@lists.ozlabs.org>; Thu, 02 Oct 2025 18:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759455095; x=1760059895; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zgov3mqg1JWQnOI+E7/IFHeQFC41StHTfUVf14re2lo=;
        b=iwSB+ETRIitQMT6zAvTp0IcMpTL8IoFut3t3jB/3clJ5MLeSNyw0lMEF9EuKnCtIOf
         KJfLybOKxsbqbjfFNEYsJnIXYYmuhbmVvVP52Kn9ogMdIJ6n0DVGPSUjyD8h2CnaaBnW
         TBNR0+dZKOCCprLAET1iuVffJzWC9vVGsznGg9yFIP6mVnR7KP92pq+3zm0daJJQ6yQp
         4qcyzrvVhLuaitjjN0Zeo/2hPEKJ4tWxPqKIdIQk55HRVLO5X0iJfQ37/1sSbiHQp3Oi
         n8AJeLeScDKx31oCp6wR/+wPUr+k/N3KTKNRjgnoAvftC5seVRUj6Vqr5FqN3LCJBex1
         PAew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759455095; x=1760059895;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zgov3mqg1JWQnOI+E7/IFHeQFC41StHTfUVf14re2lo=;
        b=FK+WG+k5T9KqUohg72S0CnlFr88fBUeBwN96qWZLz8CV0HNHZxxq9B9lDBLk7hRV7e
         hBHWrzY1PmxCoOTRfWFLRVoOQnMzqx+Ub5oncg06QPZTgzob08nEN2kg0aHb70Z3aDle
         0o4jxlEaB7fRSgEjRNlbveON3ogKwp0w7KS3+cMddBvXDWX0d6aEbZsVtdftDtrVQcgB
         WzNZOG9yTuw/JNY1R/3TtJzC9Ks8Oyy9j2Goc+n1NlKY+pcy9HjumSpPP+jAkDPsI2FE
         BDm6vftpmPM//CEZKhudj2BZcuWerEfAG3Liqpj1QTCz3AwSD8F6CnNPBaL6FDbQqPh4
         cJQw==
X-Forwarded-Encrypted: i=1; AJvYcCXenGAF3RGyxG1pPRZg+AQgd2ef6SoH/fR6HUCqMf/EsNfSgFIJPi/jkyJjaLwuOBHyNB+Cw4PWoN3t9Dc=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwVCKDpOJ/Ek2N3UanLd6022LySycOy9rgd7SEYeZdcIp2WB5iT
	I+hrpFAu78qcSSQYGbDLa5ZxIaY5Rzmlzt2pzTUXNM6qy2iUPya6XgMUmezZlD7L6siUG/+ZJLg
	YNx4dusF1BoERQmdU+3GznMRwcunwoIQ=
X-Gm-Gg: ASbGncvh1adznUJ5V8fu2lFEf9BSBKeLxicuI5uAk83E2qB5HH+HhIggovKA2HF3XEp
	dDkdtPnkSrAVa7EWbr5poMddauWNSKYZhbi8lW1lMCkZwX5fRItSsLWlfvBEvK/rAT/v6E5hT3K
	uDpaCabzLvcHPyDh6UeiitvFH4GKTmsagcB53CJScjqalNC0JWh/A9qkPW5A7WRxa883mZF2evX
	X1MEbc3ten7jeE1WDJ5GXe2HqUiTG7f
X-Google-Smtp-Source: AGHT+IFBBcoMSyrE+QoQm3Vaigr5y1LjVm/kF3OscSB6SjPP3hDzPLZ08qOkm20G5zQLmkLNSTYxFMbrlzXKgiaBYPw=
X-Received: by 2002:a17:90b:1c83:b0:32e:7270:94aa with SMTP id
 98e67ed59e1d1-339c27ba06cmr1415539a91.19.1759455094873; Thu, 02 Oct 2025
 18:31:34 -0700 (PDT)
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
 <CABh9gBcKt1zqvMQ=390HESPR5KrA42jaMFj9Ca4qmeS0d0ToAw@mail.gmail.com> <20251002-outmost-epic-9cb3bab4d352@spud>
In-Reply-To: <20251002-outmost-epic-9cb3bab4d352@spud>
From: Kevin Tung <kevin.tung.openbmc@gmail.com>
Date: Fri, 3 Oct 2025 09:31:23 +0800
X-Gm-Features: AS18NWAaCZIp75UYU-ToloKyuCFQ_kzh-3GlXmpsdfd_oQHvUv7DZqqak8PB7Qk
Message-ID: <CABh9gBebhm3o49o81JcZTLAJZhQDEocJs7inUS+Gn46zOK5DNw@mail.gmail.com>
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

On Fri, Oct 3, 2025 at 2:35=E2=80=AFAM Conor Dooley <conor@kernel.org> wrot=
e:
>
> On Thu, Oct 02, 2025 at 12:23:47PM +0800, Kevin Tung wrote:
> > On Thu, Oct 2, 2025 at 2:33=E2=80=AFAM Conor Dooley <conor@kernel.org> =
wrote:
> > >
> > > On Wed, Oct 01, 2025 at 04:47:50PM +0800, Kevin Tung wrote:
> > > > Document the new compatibles used on Meta Yosemite5.
> > > >
> > > > Signed-off-by: Kevin Tung <kevin.tung.openbmc@gmail.com>
> > >
> > > You've repeatedly ignored my ack, so I assume you don't want it.
> > > Maybe you want a nak instead?
> > >
> >
> > Apologies for ignoring your ack repeatedly, that was not intentional.
> > I truly value your review and will make sure to include it. Would you
> > suggest that I send a v4 to pick it up, or is it fine to carry it
> > forward in the next revision?
> > Thank you again for taking the time to review my patches.
>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
>
> The maintainer will add it when they apply, there's no need to make
> another version for this alone.
>
Got it, thanks for clarifying.
> >
> > Kevin
> > > > ---
> > > >  Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
> > > >  1 file changed, 1 insertion(+)
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.ya=
ml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
> > > > index 456dbf7b5ec8f4442be815284e1ad085287dc443..6f2b12f96bd6ce31b41=
75e109a78d931dffdfe28 100644
> > > > --- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
> > > > +++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
> > > > @@ -89,6 +89,7 @@ properties:
> > > >                - facebook,minerva-cmc
> > > >                - facebook,santabarbara-bmc
> > > >                - facebook,yosemite4-bmc
> > > > +              - facebook,yosemite5-bmc
> > > >                - ibm,blueridge-bmc
> > > >                - ibm,everest-bmc
> > > >                - ibm,fuji-bmc
> > > >
> > > > --
> > > > 2.51.0
> > > >

