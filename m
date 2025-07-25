Return-Path: <linux-aspeed+bounces-1831-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76B72C83F26
	for <linux-aspeed@archiver.kernel.org>; Fri, 25 Jul 2025 05:20:25 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bpGRD0cq8z30RJ;
	Fri, 25 Jul 2025 15:20:24 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::102b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1753420824;
	cv=none; b=WLG1WBvCDrnYWWUV5zGHYDlurKroZ9AQQPADY8xqJHoG+nwByZ1Dt04IJZKWFZnd6aKdjQHxigpcRegZbmk52d61UsFAsn7kP43liTDdQM5+yh6FTvEehPh0BD8ygIquS+wXuDtW3TMUTLYfmz+PaJAeKWzbr8ZerWaNMQHJRH7Rv30FSSknQe+i3r4+aPsz2B8bQK2twXYv1NIF+o76+wiik0exZScWvS3vNpihGUl/59NoDSAmkaYZ+ijVLMEaxfNaPyanIqp5nSd5f30BIcSlF/m/aYw6wu7trOK4UDzVWV/qmetXd2rQDmT9tg0ozk3KOjpi0WLc6ouLf823dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1753420824; c=relaxed/relaxed;
	bh=nLFW2Etg7f00kiQg1GB1r0zuU1sWnFWDprHgwFRfFp4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bFTg2qMTG5E3JaA0PQpMkje4lSA79ACSw8MOC/gDRoBpgfqEBQi4RXeoekWH7rt+5eBmMZ91S+GMdhp8vbHF7lhj5YHe9m8hrmKZxg3KapM3PfBFMjZBeeR7ThdYMULOgdGukmX0FZpJO4J4+yU6IomsSpurah6ZXAsDqgyXQI8qJfZ428mmq8AoAtWvjoiv0reiOBmqJsF/PBewnSEYeytAWzlCbpYbGHPpDS0c0UPbPvCUcWlK/By+Ogs1HqKXo+a46ARi1Py/sxWif00nra1hInhrT5Fthjxc/4NfBw8m+uJe1b6i0JJAsNs8iHGAx0dOzKHS2tfbJM6xGXKZ+A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=kaVaFPg0; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::102b; helo=mail-pj1-x102b.google.com; envelope-from=rentao.bupt@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=kaVaFPg0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102b; helo=mail-pj1-x102b.google.com; envelope-from=rentao.bupt@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bpGRC3jkhz2xCW
	for <linux-aspeed@lists.ozlabs.org>; Fri, 25 Jul 2025 15:20:23 +1000 (AEST)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-3137c20213cso1583748a91.3
        for <linux-aspeed@lists.ozlabs.org>; Thu, 24 Jul 2025 22:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753420821; x=1754025621; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nLFW2Etg7f00kiQg1GB1r0zuU1sWnFWDprHgwFRfFp4=;
        b=kaVaFPg0svsHkcmFFgul5BzURSnV6p4WbvXLqutuluSx8qrvqOBqhIISbFwjrSZEc4
         Z1zvjZiYbI8wK1a0E7CskQRU4yQLbs7xdEgInG2jAgsHAwzpeIAHHsEqr44Q/mpCU+/Q
         moSLgs4vKOs9W/qkTshmgUAUTw0nFYSWxH03Iz7gbJEy1sq4nsQzhzhuBbVc/ATzogdC
         YnHyUGGsuAYL50Dg9E/6sWUAgqTXnuKxvHd7FhmzYzoM7tm7KwQg1knTerLv0p8ffTq2
         5YlEuELX5iW/c99xyY7pzqGfzO4we5MuSvWOfIy9TTXEwEKnTtAXg5EGWJGm4v+ijRI+
         D7ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753420821; x=1754025621;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nLFW2Etg7f00kiQg1GB1r0zuU1sWnFWDprHgwFRfFp4=;
        b=wlGide0ikG/DacffaebKCiUPBqFNbjX17yuwgC23vsdTslzNvkJdxhZM63+McisGiY
         oZxc/UXVGsDXzEmC29rzteAOX+9Uo/Dapg65PQxFx6LEMEcJfv3muoT3Facj3uHZnoHb
         kqYooxuXLwnVpO3bpKRO2c30lbGHnzpKGvWv8VECZOJV36+b8wskNGNbgMmSniii0+ky
         41Zo2qg7aQ60oDQFKtL4S8+lFI3fyhGnejr4wvIFmsaQnA4+AOngfyK0eF74zqa3nfJk
         +rAXC+HRNbJ9FUwdi4DAvAY69vd2B9pCHJo2ZnkXOJ+fSJNx2iLXwnTFNNuffTCvQyHd
         HS3w==
X-Forwarded-Encrypted: i=1; AJvYcCU1gEBBKVBWZPWyPCyHJIUON9ti9rWbM4E3D4IkGqu1Z8ifWdJnvvRWTAyB6UyeJV0OQvsVp93fQ2vQtRY=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwRj+oUJUon8NEDrixbVXz1mLAsDoH8tgySHLHBVBnLf2Y9f7xc
	71J0pp46uJMSiM6VzULThlolO+GQWukpaZ8LdzrzgjKXvNb7C32NkOdV
X-Gm-Gg: ASbGnct8ev9GnpH02lrGolNhSuypfcbUvX7fUr2P0UsxRgENdQaAc1DSC592EBQhWE+
	AArH2dvetZLhzizY5Xy/611Ct+Q+fh48anCgfZIVxWmZI7jbcisY+I6QhMZslqV5hedmH/RXnrR
	2Ck5L5zHA8c+CdSS2UqX2mChV+QiqyMUkaIKCUDVgpS4pPea6Gy/w4ClOtHRWe5ONbxftHu+GpS
	YKU4WChaRG+fszVbsPv8L8tTkdn/O8k/k2wFW+n7Kgeop2V80p/UkHanR/otb5LPiP//fd9tfHA
	PvlVj8s6RiHloPt6pVIEh5ECj39IZ5cuKZTiaEDdpm3aWUsBPqOt73PsfzlIrDlNvs/yP5gcBZv
	XEEQfVE+3dflGb/7Ax+DMM6DvjjU1L2s27j2uO+t0b2U3AMyy1gPqJSXcyQVFnTHByXctfFrPrJ
	E=
X-Google-Smtp-Source: AGHT+IGYNEkx+OPyKPH2NYgCMOjXtnrPHP45w1/H3ht6Anh5i8C5DhT9XfjH7TYWya6okH861qSVtA==
X-Received: by 2002:a17:90b:2cc4:b0:312:25dd:1c99 with SMTP id 98e67ed59e1d1-31e779fd277mr795087a91.19.1753420821482;
        Thu, 24 Jul 2025 22:20:21 -0700 (PDT)
Received: from localhost.localdomain (c-76-133-73-115.hsd1.ca.comcast.net. [76.133.73.115])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31e609617aasm2308647a91.0.2025.07.24.22.20.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 22:20:21 -0700 (PDT)
Date: Thu, 24 Jul 2025 22:20:18 -0700
From: Tao Ren <rentao.bupt@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	Andrew Lunn <andrew@lunn.ch>, Tao Ren <taoren@meta.com>
Subject: Re: [PATCH v3 07/13] ARM: dts: aspeed: Add Facebook Wedge400-data64
 (AST2500) BMC
Message-ID: <aIMUEhoCXU1C8em4@localhost.localdomain>
References: <20250723233013.142337-1-rentao.bupt@gmail.com>
 <20250723233013.142337-8-rentao.bupt@gmail.com>
 <20250724-overjoyed-panther-from-camelot-f2ff4f@kuoka>
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
In-Reply-To: <20250724-overjoyed-panther-from-camelot-f2ff4f@kuoka>

On Thu, Jul 24, 2025 at 10:05:40AM +0200, Krzysztof Kozlowski wrote:
> On Wed, Jul 23, 2025 at 04:30:03PM -0700, rentao.bupt@gmail.com wrote:
> > +		/*
> > +		 * PCA9548 (11-0076) provides 8 channels connecting to
> > +		 * FCM (Fan Controller Module).
> > +		 */
> > +		i2c32 = &imux32;
> > +		i2c33 = &imux33;
> > +		i2c34 = &imux34;
> > +		i2c35 = &imux35;
> > +		i2c36 = &imux36;
> > +		i2c37 = &imux37;
> > +		i2c38 = &imux38;
> > +		i2c39 = &imux39;
> > +
> > +		spi2 = &spi_gpio;
> > +	};
> > +
> > +	chosen {
> > +		stdout-path = &uart1;
> > +		bootargs = "console=ttyS0,9600n8 root=/dev/ram rw";
> 
> Drop bootargs. You are duplicating stdout path and choice of root is
> definitely not a mainline user friendly.
> 
> Best regards,
> Krzysztof

Got it. I will drop bootargs in v4.

Thanks,

Tao

