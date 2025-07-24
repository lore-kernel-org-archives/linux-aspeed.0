Return-Path: <linux-aspeed+bounces-1819-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22037C83F17
	for <linux-aspeed@archiver.kernel.org>; Thu, 24 Jul 2025 01:04:00 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bnXnp2Kf6z30TG;
	Thu, 24 Jul 2025 11:03:58 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1753319038;
	cv=none; b=GvHisUbn3BZ//uY5XU0A37poFYLv/o3TS5iXJ3zyJvDg4ykAKs22aGw08SP469vNGpthp1mlXglCinSXUGyl4oP6ajyXuZ8QNiD8sKalovH1pdFqDVlEhe3onF0djTWUfPcpQNG/MCpY1vetrlaqbfjFBwJOfVE6zbV5KdkVVbqxaTVyMtkuy15YoZD4qdeFumfqN2jOvra36jBgOlV08AHtzHWT+dadpKtcGM1LtVTwPYI1t2wK6IZzoI5YKsdN1EyLzVuytIg9MG2o+q6uDVpzFOuBdfspvkYM3EbMOVPt3LLCZP5FJ5GreN8YVs8JiW4qalyxqCvbjVHvB5+rUg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1753319038; c=relaxed/relaxed;
	bh=ola36QVTNrbThBTKVTSKPubN1/zqev6+ed2BRlcpJ0o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TPV1LGOwoMLV5cJaU/Gy1La+tAlGOKX+Opl8PqQCq6n527GoXJJLTlExK0cGnkNDAcsFwsV30YjMrZU14gLpm+dS05ebCkqgUE7Z8DU3lbQxaYodioLQC3FCUdeUpKeDYwvnDW5y8b82muT54ZA7tnj5DNbOElqpiSwVR84/spXG1i1V4HSTCwiWdAD3Bu9ieZdsCyIAH1esPRW+lRBKedM0dHKlY/WYicmFIr6etoXGj9FwvLfm5E3g3q+EKDaJOv3XulH3aWLGv6Rtjj6K+wznsmTrNIfCkJld0tiMN5+1YAzHblgwTcf6vWNJAvLMb0tVDLTjOrHFyI2PuV8U1w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Qh9Pv7fA; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62d; helo=mail-pl1-x62d.google.com; envelope-from=rentao.bupt@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Qh9Pv7fA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62d; helo=mail-pl1-x62d.google.com; envelope-from=rentao.bupt@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bnXnm3lGKz30T0
	for <linux-aspeed@lists.ozlabs.org>; Thu, 24 Jul 2025 11:03:55 +1000 (AEST)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-23f8d27eeeaso3564945ad.2
        for <linux-aspeed@lists.ozlabs.org>; Wed, 23 Jul 2025 18:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753319033; x=1753923833; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ola36QVTNrbThBTKVTSKPubN1/zqev6+ed2BRlcpJ0o=;
        b=Qh9Pv7fAQYwrkhtjJxSG242ZkZFkcqdmOxfCWvaecCWNhFvw+M4uuO9hD1+0IrRJpm
         /MPJx291mgr+scneNZNLI3qXILS+hzid1WLpnO5/3Q2IkOgFBfciSRLm3E3cpzVIwRc9
         vcueGw4f7wtrvESsWbFgeTJObUOeWrMh6JZteOjmde6dqKqyqoaXcEfETOz8uLLPgUNX
         PDNBwH7Ey4PFjP8kcQ6cWTsSMg9eGAwl/oKy85vEk1b31NItCtycFkoiWsOqNmcDx1nH
         Q4prVKX+60EpkKx6brYO+ViT+X9BfK2kKTZ1mxXdH2eH6U8uc1yWTDKykzm8aM4rXh7T
         AfRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753319033; x=1753923833;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ola36QVTNrbThBTKVTSKPubN1/zqev6+ed2BRlcpJ0o=;
        b=LfpfHSMla4sJfsToLy7D/ZgKJ3q1rdAabo28VBsrhrRUxl+xQkp1pAF1N2w1VQ1o4F
         n20Y4rarb+6yH/sJUKyAEYbl/z0iK2iF00bW5tt1KxSzGBomfPX9XAhPeBL0mg1t/7d5
         FUQccpUyNFGNlaNPTOoJQEsYxnRQlwO7vTgLLQJe+eqLm75ZU9KCJhD3PfADbqxrw7ML
         bmcoJkGuD/t4dDsw8uWITRh6s7ZffFX0YuCEq8DLInU+KfTIo0OZcI6C2eqgCG062zec
         v7znVURfH1+k3OdzkAoRvJJYvK8VxgVXDtFMkt3SHGeg64rNANa9GIe8IhvEORLrF+hy
         u09Q==
X-Forwarded-Encrypted: i=1; AJvYcCVKfjMp1J83plLN4qgmo0tND8UvAs8I6DjOKpDVrsxgllMrFq+MI2E0GBxEEf93M701ddILKaMdcBxR4zw=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxvxQtTndd4A1M5EDzgYDLS2EhLAt/jq+5+EwTKXqQ5SDPcfNxl
	sQZKBT0vkPMlYWU/Z5vEllbcJGOJ+jnoXG/W4Ug9zymPk2NnIiTNZ2Pp
X-Gm-Gg: ASbGncvjxZkfDv9t4b1bKWTmA1HzcweEzHsigayroklfRESSRfL/Q4P3RBLvHgMqSF5
	3Ss9C34VyDrOfX1arIEFARikokp5s6MXmNW8Bb5a5QMAEx/w2wL8K7jAgxserBXwSutkfE5O4YQ
	/ptDByJDoDSctEKfNV19lC75xfUyDetYZ/ZZPC62g0VMlrg9Y43ytM5ubab73I86YaWTKfkvx4t
	mT6YrQ/ZZcqUaoCNZTFMx4bXiEMHTQO3UVrW/jCfppXaju4s112kPnkpFKTmmVH0AAPWZmFRx+I
	IKy0PQr74PJjh1YYYlRnAqs8sVEHdE7Fnic5EAF/ONwNlSUkqWaxjJs/VpqKeKBcNUBMo6SOhMH
	xIFpIYXsVzBFSGtPVQ3JNkC812z81dbqVVQfsECJun8YTRg2mXwP7roEiTsbvoSRUdXTQ6glDdh
	s=
X-Google-Smtp-Source: AGHT+IFgaOGMceKN4aw59L0CUk1l7GDQtyX01Zhw6G9VYFu6+CkQUCsVgi4C70MsUhb+musZe+qrOg==
X-Received: by 2002:a17:903:1a2c:b0:234:e7aa:5d9b with SMTP id d9443c01a7336-23f9814c6damr56396695ad.23.1753319032958;
        Wed, 23 Jul 2025 18:03:52 -0700 (PDT)
Received: from localhost.localdomain (c-76-133-73-115.hsd1.ca.comcast.net. [76.133.73.115])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fa48f04afsm2229035ad.163.2025.07.23.18.03.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 18:03:52 -0700 (PDT)
Date: Wed, 23 Jul 2025 18:03:49 -0700
From: Tao Ren <rentao.bupt@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	Tao Ren <taoren@meta.com>
Subject: Re: [PATCH v3 10/13] ARM: dts: aspeed: Add Facebook Fuji-data64
 (AST2600) Board
Message-ID: <aIGGdbIX9HaV4dB/@localhost.localdomain>
References: <20250723233013.142337-1-rentao.bupt@gmail.com>
 <20250723233013.142337-11-rentao.bupt@gmail.com>
 <d09667e5-992e-4ced-ae30-7a4116a72c62@lunn.ch>
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
In-Reply-To: <d09667e5-992e-4ced-ae30-7a4116a72c62@lunn.ch>

On Thu, Jul 24, 2025 at 02:03:20AM +0200, Andrew Lunn wrote:
> > +&mac3 {
> > +	status = "okay";
> > +	phy-mode = "rgmii";
> 
> Does the PCB have extra long clock lines to implement the 2ns delay?
> 
> 	Andrew

Hi Andrew,

Thank you for catching it. I didn't notice the settings because the file
is copied from the exiting fuji.dts with minor changes.

The delay is currently introduced on MAC side (by manually setting SCU
registers), but I guess I can update phy-mode to "rgmii-id" so the delay
can be handled by the PHY?


Thanks,

Tao

