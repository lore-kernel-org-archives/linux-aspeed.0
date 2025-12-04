Return-Path: <linux-aspeed+bounces-3036-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E30AD1CDB2
	for <linux-aspeed@archiver.kernel.org>; Thu,  4 Dec 2025 00:30:03 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dMFlF3z47z301X;
	Thu, 04 Dec 2025 11:30:01 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1764808201;
	cv=none; b=h6O6awluUK4uphgtRWYMSnzmT5MzQ35iESd/Ct1lnaAiTAu5GnixuodFbtHDcUTNIZC2JqBb1qzmO6DA4dUSxFAFIOCKo2qgkZGrTyG58YqMAEsqFPDvN+M3hOZYvgSk4E9r3tX5YhdB2mP901cm0288Y9aRnuMNJBF62mIgT1eF88b90TXpxjXB0Wt0DN2+fSOgEr/pkm529T08h25ef5SVLyHv+q4RPer/EaneP+OUPLJ5p2VDdlpt8lcruvhbwpcV1KmuNi8erbKllSuU00htxVhg27y1HjwpmU3ncXqCasTpNthSPDEw/2XXKRarulFn7Bq7JTjlBJBjZyc3lg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1764808201; c=relaxed/relaxed;
	bh=vWBsNUAQJIiGx0STKoYuLr8WVpYlwo8t8SdzJPcQFDQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=PoXP6FjAgihrS3G/Nz8/vJARCmsPlSxmD4HwYElNxV8Ie5qV5FZTnU7wKx97VF98D9hauRsxA419tcJiIrV2MDTYfswbvPTAUqHf2xCP+eqvuIlhJA5HJNqbYyprXOavQLYxhtdkIY4drp8EyAP6/BSXrq3dk0Lq+bILmKzvnSHM0OjIqkQ9/YFOveLUrcqp4ByVwT28U8BjaQMQTChCehXxLFTZOdT/HhnWuQNmqX3C2ns4LxugTnIVb0ujNB9PWMETrADSdD9reHEyADLu0QdLZLJCV0i8BRv5PrKExVS8ewhBC/7ga4PzTDcVuTgBbJK6m5qjVppTIigIDjusTw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=doUBzLPz; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=doUBzLPz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dMFlD1ny2z2xSX
	for <linux-aspeed@lists.ozlabs.org>; Thu, 04 Dec 2025 11:29:59 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1764808198;
	bh=vWBsNUAQJIiGx0STKoYuLr8WVpYlwo8t8SdzJPcQFDQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=doUBzLPza/HGmbXlMjkGYgJH9J3XGP0tOvNLFlG+2hodaoSzhigj/6guKQWwq5h0K
	 QGcU9DaIIuGaix4BL40TQpecxf0jLfcNpltp6Oqi5S344wKqq1RTlXE517s0zyTfWo
	 BQKjnmitUEpkumV4dZmPOPHRomMJmVyBrSTozxK5L+hDnGq0FWvO2TfGy+kSraiPmN
	 nVJwwU3jeYMMGihBl6l2QkaZ9SrMZJ07I91cPlldkzhz/gyrnWXGu7W/jjwXdLjmnP
	 mERV0shEXTBP8l8IH7VCmXiHCexozLwRJDmnG3jg1sDrU0zngz/kmW3ERo6B7WHtZK
	 mTZ5ht8aTUVHw==
Received: from [127.0.1.1] (unknown [180.150.112.216])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id AAAD0706D2;
	Thu,  4 Dec 2025 08:29:56 +0800 (AWST)
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Marc Olberding <molberding@nvidia.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Conor Dooley <conor.dooley@microchip.com>
In-Reply-To: <20251126-msx1_devicetree-v5-0-e508d13e2dda@nvidia.com>
References: <20251126-msx1_devicetree-v5-0-e508d13e2dda@nvidia.com>
Subject: Re: [PATCH v5 0/2] Add device tree for NVIDIA BMC MSX4 CX8
 switchboard
Message-Id: <176480819607.976941.8757303196020007882.b4-ty@codeconstruct.com.au>
Date: Thu, 04 Dec 2025 10:59:56 +1030
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3

On Wed, 26 Nov 2025 16:43:05 -0800, Marc Olberding wrote:
> Patch 1 Adds the binding for the MSX4 CX8 switchboard
> Patch 2 Adds the device tree for the MSX4 CX8 switchboard reference implementation.
> 
> This is an Aspeed AST2600 based reference implementation for a BMC
> managing the NVIDIA MGX CX8 switchboard.
> 
> Reference to Ast2600 Soc [1].
> Reference to host architecture [2].
> 
> [...]

Thanks, I've applied this to the BMC tree.

-- 
Andrew Jeffery <andrew@codeconstruct.com.au>


