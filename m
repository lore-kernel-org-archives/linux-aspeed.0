Return-Path: <linux-aspeed+bounces-3002-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64B7AD1038C
	for <linux-aspeed@archiver.kernel.org>; Wed, 26 Nov 2025 08:57:33 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dGYNW4WyQz2ynP;
	Wed, 26 Nov 2025 19:57:31 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::122f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1764147451;
	cv=none; b=DFjiWug9YlxX3G0Dog0OMQFi1E4/8kqNg9lDXGrjVvwCVvBN3BiNYRBz+kDK0+piOzaX5x2/1oqi/1OdjDVjT4QSBZoAj/+8Xy3cbxLSl2lAp3/mnMpeVcUKRx4uYya+8x5WFu+5tPAWSDvmRUNq5dz7QL2dFjzz+iSu4XgD1VYRdWtuW+QbdC7kTNKgO20LZVEdhmz+0z7hf1ZKFsKANADiEG6eUzMb7T09C6W4sT0qbZob3bgO602PdOSYDwXnWZJzlX8Fyl97pnEAN6cexV44JXc2qyZGfZzuZq5urj+jtDyKT/i64sSC3PLnze6Tgn9yAJmWe/ns1trOa68UUg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1764147451; c=relaxed/relaxed;
	bh=OyD4sn9jsMLtWXgnyFdyRLUkPxYCW2TqpmGHV9ixsxU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h4bu1NqVMIOWHB+N7B+7AV9b0vuGHlOK1CxzGtqmPyrYV2d0EN2pMGkEdommPlF8cob0O1Uy8QpL9zVcQHuZes/KC6Y0s1eW36MxGGMH5nCsgwDRl8evfKoASPR0NefkNQGOfj4ICFeMlK6nSQsocAeTelLZzSyJdh3mwJ+Wu/KRy219rge4G5M/ARFPGs6AmpezlyS9zCtZyA46Gd/1suRIlL+A+UkB3qv66x+pPJ79QLGA8qL2ecXyowdRfi3cIsYt0zaFKvSJFGXb8UDzwng99LDUStZU3xMEbhjOo2NNqHGq2NJNfjYs4p9EP7l00b+QEurKYc8LDYtR8MvBZQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=cWmaGLRx; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::122f; helo=mail-dl1-x122f.google.com; envelope-from=rentao.bupt@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=cWmaGLRx;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::122f; helo=mail-dl1-x122f.google.com; envelope-from=rentao.bupt@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dl1-x122f.google.com (mail-dl1-x122f.google.com [IPv6:2607:f8b0:4864:20::122f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dGYNV1GSvz2xPB
	for <linux-aspeed@lists.ozlabs.org>; Wed, 26 Nov 2025 19:57:28 +1100 (AEDT)
Received: by mail-dl1-x122f.google.com with SMTP id a92af1059eb24-11b6bc976d6so808296c88.0
        for <linux-aspeed@lists.ozlabs.org>; Wed, 26 Nov 2025 00:57:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764147446; x=1764752246; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OyD4sn9jsMLtWXgnyFdyRLUkPxYCW2TqpmGHV9ixsxU=;
        b=cWmaGLRxU1cL8qjtuwSVblS2YQdRAMe2Aikt3Las35thd2DBR0INenxKJkZvUC+NZC
         43srWnA2dnWaurxzQv08lKZfNT0nX7rRn1spPDftzk6lCthAn0/UJWeqdQyeYFbyYATF
         dOeJ9oen1ARMEwpnU9zYosG87Qrw5TS4A6aJk8omEn2AHTXL1sECyVyL2rvsHxtWVTvS
         ZcE8uSTG9Mbgo8vuqrGpABhHc1/oNDxRgd/XDUG8y8pECb8UeacXlm78N80Wau+gQDGN
         grTHyT8YFYgkzqFi4bjkOUlpFwA5aMj1KxL/uDn5WLEZ3YtjFyF6VS3FSbHBkhhGAAQI
         Qf0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764147446; x=1764752246;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OyD4sn9jsMLtWXgnyFdyRLUkPxYCW2TqpmGHV9ixsxU=;
        b=oOB6Awq8H+UCPeMfV562Ubjaagv5AvCgu+wK1vdlMLNs7KNYbA6CPD4gDx1daS00Rj
         rAHkJheojgj6ITH48cKZN/M+RdEH7LAG4a9VvZF/+KK3hCGgf6XrFZB6g5gwh+7j17gK
         tQCuW3dI0HEzLg/m+RsrhCtkKUHTn2hgD8N5tuSl4Nh7UNvsA7ZmXNE5srhgDr0aQdTN
         QBSLP9cJLIdiExQ8+0OXWzYQebdMBYrbJ3ma4/fBXFM9TcxuigW3j0cD2nFQhArqL50Q
         ExTJPg8fvTZIVSadrGFuiVx2/5ZH7Zd31lQU+JzrUoikNBwElWr3wFJn1XV+cOrEh+Cx
         zrJw==
X-Forwarded-Encrypted: i=1; AJvYcCUvZbX+kVuOxu5YMWmzoa6ueXS4biakullhN0NVF6aIkiy3i9YaiCwRETKjWN/qJBGhk8NcVdpYJ5sAVsY=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzgGGORbUTHd44yb1Bk8ve5e6q+gyGWYUVnIqvHOof7TmP3CK6m
	icUR2SvVP0iaXI+cAXYNwuwwZta+NwGZjvT4rZ34z8DRgUgfxFBjZtT/
X-Gm-Gg: ASbGncslAD9peOb++R8PjTECqO8APJCR3izgF1lLWY4ITE5sPhniF6WLsOoAybbEu5R
	M0xYdhn8lvhkxXKJ5TsBDffxRTW8DH+q2y3SEhPeWI6iY1w+TVScYzZ/Pfebb0ioiF8dyUlyAqW
	GnCoLPXOERh63AoIZOkyqAcm1wxjoMPUzNrlOMKGnBFM5Ui7Zs656C0EZlHfyBc13bpMMuGSClZ
	2T97zZ+oy2+ff6UhEoRcmn9C+r3wrbIokkm5egfZ+gT9FibKUyaadMbeuajt6wyGSh1g7yfwY8H
	6phV64rlR2NEBQb4Nkkd1Fe2rphi03uC2vbiJOX1Vy7QJFyDJyJD7fW+fBbnPwbCqks0tLjWtSA
	6GaAw5qGaVAWUsAEa6v2iavBpd3W46efwVWLyXKtdCYBHGgpaScVlsJZpkFtsQSJFrjgjxp+4s6
	5vk6VWVGkkI3yu+QNduGn8Evjqfk0ursCKlxEnetb3esQ=
X-Google-Smtp-Source: AGHT+IFrIMIkTPrxwRfvEMQ5cEoCTFWA9fomBn7RLpjcNkpm60ZPM71v6rIQ9mqGMQwZqmC/nqOzYQ==
X-Received: by 2002:a05:7022:ec17:b0:11b:9386:a382 with SMTP id a92af1059eb24-11c9cabc4f0mr12703137c88.21.1764147445929;
        Wed, 26 Nov 2025 00:57:25 -0800 (PST)
Received: from fedora (c-76-133-73-115.hsd1.ca.comcast.net. [76.133.73.115])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11c93db556csm92664267c88.1.2025.11.26.00.57.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 00:57:25 -0800 (PST)
Date: Wed, 26 Nov 2025 00:57:22 -0800
From: Tao Ren <rentao.bupt@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Jacky Chou <jacky_chou@aspeedtech.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Po-Yu Chuang <ratbert@faraday-tech.com>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
	"taoren@meta.com" <taoren@meta.com>
Subject: Re: [PATCH net-next v4 4/4] net: ftgmac100: Add RGMII delay support
 for AST2600
Message-ID: <aSbA8i5S36GeryXc@fedora>
References: <20251110-rgmii_delay_2600-v4-0-5cad32c766f7@aspeedtech.com>
 <20251110-rgmii_delay_2600-v4-4-5cad32c766f7@aspeedtech.com>
 <68f10ee1-d4c8-4498-88b0-90c26d606466@lunn.ch>
 <SEYPR06MB5134EBA2235B3D4BE39B19359DCCA@SEYPR06MB5134.apcprd06.prod.outlook.com>
 <3af52caa-88a7-4b88-bd92-fd47421cc81a@lunn.ch>
 <SEYPR06MB51342977EC2246163D14BDC19DCDA@SEYPR06MB5134.apcprd06.prod.outlook.com>
 <041e23a2-67e6-4ebb-aee5-14400491f99c@lunn.ch>
 <SEYPR06MB5134BC17E80DB66DD385024D9DD1A@SEYPR06MB5134.apcprd06.prod.outlook.com>
 <1c2ace4e-f3bb-4efa-a621-53c3711f46cb@lunn.ch>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1c2ace4e-f3bb-4efa-a621-53c3711f46cb@lunn.ch>

Hi Andrew,

On Wed, Nov 26, 2025 at 12:49:57AM +0100, Andrew Lunn wrote:
> > I try to summary in the following informations that I understand.
> > 
> > 1. with rx-internal-delay-ps OR tx-internal-delay-ps OR both
> > 
> >   Use "rx/tx-internal-delay-ps" property to configure RGMII delay at MAC side
> >   Pass "phy-mode" to PHY driver by calling of_phy_get_and_connect()
> 
> Yes, since they are new properties, you can assume the phy-mode is
> correct for these delays. We just need to watch out for DT developers
> setting these delays to 2000ps and 'rgmii', which would be against the
> guidelines.
> 
> 
> > 2. withour rx-internal-delay-ps AND tx-internal-delay-ps
> > 
> >   If "phy-mode" is 'rgmii-rxid' or 'rgmii-txid':
> > 	Keep original delay
> > 	Print Warning message
> > 	  "Update 'phy-mode' to rgmii-id and add 'rx/tx-internal-delay-ps'"
> > 
> > There are FOUR conditions in delay configuration:
> > 'X' means RGMII delay setting from bootloader
> > A: 7500 <= X <= 8000, 0 <= X <= 500
> > B: 500 < X < 1500
> > C: 1500 <= X <= 2500
> > 	Mean "Enable RGMII delay" at MAC side
> > D: 2500 < X < 7500
> > 
> >   If "phy-mode" is 'rgmii':
> > 	Condition A:
> > 		Keep original delay
> > 		Update "phy-mode" to 'rgmii-id'
> > 		Print Information message
> > 			"Forced 'phy-mode' to rgmii-id"
> 
> So 0 <= X <= 500 is a small tuning value, so yes, is correct.
> 
> > 	Condition B and D
> > 		Keep original delay
> > 		Print Warning message
> > 	  		"Update 'phy-mode' to rgmii-id and add 'rx/tx-internal-delay-ps'"
> 
> Yes.
> 
> > 	Condition C:
> > 		Disable RGMII delay at MAC side
> > 		Update "phy-mode" to 'rgmii-id'
> > 		Print Warning message
> > 	  		"Update 'phy-mode' to rgmii-id and add 'rx/tx-internal-delay-ps'"
> 
> 'rx/tx-internal-delay-ps are probably not required in this case, the
> 2ns from the PHY is probably sufficient.
> 
> > 
> >   If "phy-mode" is 'rgmii-id':
> > 	Condition A:
> > 		Keep original delay
> > 		Keep "phy-mode" to 'rgmii-id'
> > 	Condition B and D
> > 		Keep original delay
> > 		Print Warning message
> > 	  		"Update 'phy-mode' to rgmii-id and add 'rx/tx-internal-delay-ps'"
> > 	Condition C:
> > 		Disable RGMII delay at MAC side
> > 		Update "phy-mode" to 'rgmii-id'
> > 		Print Warning message
> > 	  		"Update 'phy-mode' to rgmii-id and add 'rx/tx-internal-delay-ps'"
> > 
> 
> These look correct.
> 
> How many different boards do you have you can test with? Do you only
> have access to RDKs? Or do you have a test farm of customer boards for
> regression testing. I would throw the patchset at as many boards as
> you can to make sure there are no regressions.

I synced with Jacky offline a few times, and I'm happy to test the
patches on my Facebook Network OpenBMC platforms.

Hi Jacky,

Looking forward to your v5, and please don't hesitate to ping me offline
if you need more info about my test hardware.


Cheers,

Tao

