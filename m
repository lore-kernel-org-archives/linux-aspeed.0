Return-Path: <linux-aspeed+bounces-1424-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEB34C71135
	for <linux-aspeed@archiver.kernel.org>; Fri, 13 Jun 2025 03:44:23 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bJQHp0ngLz2yNB;
	Fri, 13 Jun 2025 13:44:22 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1749786262;
	cv=none; b=LUabA/x5no8jjAhCqtCgmPGKWUYr7wOl2M1ulq1sDFkWFSWYXQ7buGX8cVMHXvrE6NKEuDkbbcLES2aOl8huF7tbR2RZvSWLlCEqrMYux2BHsJaIOG2MRe1xPK0noAobhuzCuqjfJMj/oie6WVtqzIJ2O/dehJZ9dKCyrpFN0ViurX3x+TNDhNPHc0ouepbWvaYhHm1D5J5gjwJo9PZVQ95Wgvr1kN7UIRC7PjLYud6tATrgHEbocH3H6SJfOU/hJkWAGKSJm/utgtoDmhDFY0XdHOHJN1aFsmdLPBtOwUGj18o6hYKSttjZ3wwYBcPPz5rU0D+EBbGJUvUbcEm2rg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1749786262; c=relaxed/relaxed;
	bh=e1p6/5wXJ3cC6mmHN/REy+JAlhOgHjO6oA0FGENkSaM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=iCQ2SOXkNgXzQsdWeHMBhTgv/MIMK3o1XylX8YpiwUIxKY01kKxZXk80x+PHZJNXI4CL8IyW4SrrpXASMOHlrr9kIJTtkFnj9hWE2/4vPOK7TSsSPG+YRUKITR7SD5WGzJzhXOXuxvJBR/lmPt/sZ25Rx/EQtvESGteWYaD5mKNrppdSQ0qzhlDrL0BYS7uYaoIIjZIsEjSuxXOW4AIgPGHtEUr9Hth8E5tFPlAE2FgjCAB2AutuHQN0qckNUnvtXS0lc8FulXbMzA9eJN6Unt5H42AwCs72hi87uvsAnStKmTuYPzbcVIBVYKNdI3B9rInw9pgvXyQ+hdG2sSFg5g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=kh0xw04V; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=kh0xw04V;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bJQHn34w8z2xKN
	for <linux-aspeed@lists.ozlabs.org>; Fri, 13 Jun 2025 13:44:21 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1749786259;
	bh=e1p6/5wXJ3cC6mmHN/REy+JAlhOgHjO6oA0FGENkSaM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=kh0xw04Vx0uKRUojByFDJGN96V6mQZJEqdgMb+sFZJrRXPR0k/Sg2AOzZJ9BmhQnz
	 ZymbgSXTWizHqtKlgh3VnX1QbxpDEHjEQRxh1mYWC4OFD9sDiwuIraTJ07M8GcuseX
	 x+hTeBuRnU5+IdVQwQenGCtRXg2BQynYziyLe4bbX+/hUSrlDChe+APzcnpTQ7H5ky
	 mLvboB8v6SZluNolUQ9O+b5dhWdHaySADQll+syYIRWIvzvWrxytIl7ob8jjULD2od
	 8sq31tiLWR80BcymTcBgJeOL2+EY+UAlnvz7fqqn1/1DVedrXC2LqHCi/6xcvSoeqX
	 xlQJ+/Qioix+g==
Received: from [127.0.1.1] (unknown [180.150.112.166])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id EF2926699C;
	Fri, 13 Jun 2025 11:44:16 +0800 (AWST)
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Patrick Williams <patrick@stwcx.xyz>, Potin Lai <potin.lai.pt@gmail.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Cosmo Chou <cosmo.chou@quantatw.com>, Potin Lai <potin.lai@quantatw.com>
In-Reply-To: <20250611-catalina-mctp-i2c-10-15-v1-1-2a882e461ed9@gmail.com>
References: <20250611-catalina-mctp-i2c-10-15-v1-1-2a882e461ed9@gmail.com>
Subject: Re: [PATCH] ARM: dts: aspeed: catalina: Enable MCTP for frontend
 NIC management
Message-Id: <174978625629.315392.14738595529417409352.b4-ty@codeconstruct.com.au>
Date: Fri, 13 Jun 2025 13:14:16 +0930
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
X-Mailer: b4 0.14.2

On Wed, 11 Jun 2025 01:02:09 +0800, Potin Lai wrote:
> Add the `mctp-controller` property and MCTP nodes to enable support for
> frontend NIC management via PLDM over MCTP.
> 
> 

Thanks, I've applied this to be picked up through the BMC tree.

-- 
Andrew Jeffery <andrew@codeconstruct.com.au>


