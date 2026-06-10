Return-Path: <linux-aspeed+bounces-4214-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F2CCCD8CB2
	for <linux-aspeed@archiver.kernel.org>; Wed, 10 Jun 2026 11:22:27 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gb3KF62Npz2yfD;
	Wed, 10 Jun 2026 21:22:25 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781090545;
	cv=none; b=POZW1hdrGU8S9hiGmoX+osiYF+FpvmzMyiXiqDO5j0l3p6cLmMCJ7O6FA795CNTckvqgPsQX6SfB1VInibrEUiEy1RrJj0VYK6aHaSvKTUecbeo60xZjynhuWv5DkE2vd4SLffyk7hu+mNzMiHS8KL1jBEXEFnNInPYLdzcGZd17Sb+W14oY92eLEuWio8D6FnFThaGVhZJ/hIGuFLsGRIxpzsdwI+Rfej8KoOcfE/2xxKqok/5FcV6lMEMufZrd5ZMfO4mT2OFl0Md+1BllggmMzJ1x9jNyHXnTWwECNLykPRRwF89FdBXFBxPzf21/5o2T0REscyL2xu3uZgqDgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781090545; c=relaxed/relaxed;
	bh=aBDEY71A7aCboQvqZmdLZCfK9+flfFgYZqgP3Td8iQw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JlVB479VrqZ8lwl0ASKTyko0YGuk5s0idDkF9mMhH7bYKEOxiOxUJsG1kNLS4zFvv7i/RL5KUa5bMRyp5dMHY9SdOKR248m7E0/4wlAUSkqzPNJsC+wT5w319iUQcaHCWUh9kN4L/Sh8iQV3PYwWwSkOO8xN9HdcIwto4hKxUmIRRYE+IDDRLSxbZKcYJEkEB09fZ8mRwv2vQnv9iy2c1/nfMF1eEtTmZ3QMQ+I4AA1u3IVwY4m9B4z2NU5KN1vsJ6Doqq9A6OBL2B3WE30s0UOHsVuy1qUH25E/0LhOVahVai32WTFYaxpX0DpK2wDvXrrhhFOJ1f2LCY46GH20RQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=LVch8VCH; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=LVch8VCH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gb3KF1YGhz2xdb
	for <linux-aspeed@lists.ozlabs.org>; Wed, 10 Jun 2026 21:22:24 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1781090544;
	bh=aBDEY71A7aCboQvqZmdLZCfK9+flfFgYZqgP3Td8iQw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=LVch8VCH0zomK1nWEJ90cjd/By0E1ewlQ5r2fkj526WecOoevRMgO1i6dynMrgDSC
	 CMKfHYRsoLGH5A6+q/WeH4LpdgVjogq8E6BWaft5NDo8vMO5YB6DxQO+BFizdyoToY
	 +SnQjofpJeFRyril0GtxrqlER1F89XaqcmaC9W/+RyoGBFHJTtxx+SlGRCPRSHzBFE
	 lZjas42RoA5evv+8gaWjzM0IN+KYkV3pni3kb+J09X1dg5bJ+pPZZhvIZL//ZHpRHW
	 MxUFftFZQ3jez5zOGwZ3jnQ1sIoaP7BCTa8OzmYR/Ed6kNmaWIydKoW1s2SogFhFR4
	 IkdElg6fpkrLg==
Received: from [192.168.68.117] (unknown [180.150.112.11])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id EFA2C60A14;
	Wed, 10 Jun 2026 19:22:23 +0800 (AWST)
Message-ID: <a8cdc7c23166823a8e1969408c667e6a8d758fe7.camel@codeconstruct.com.au>
Subject: Re: [PATCH v6 2/2] ARM: dts: aspeed: ventura2: Add Meta ventura2 BMC
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Kyle Hsieh <kylehsieh1995@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski
	 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joel Stanley
	 <joel@jms.id.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date: Wed, 10 Jun 2026 20:52:23 +0930
In-Reply-To: <20260610-ventura2_initial_dts-v6-2-375d8e9d7ebf@gmail.com>
References: <20260610-ventura2_initial_dts-v6-0-375d8e9d7ebf@gmail.com>
	 <20260610-ventura2_initial_dts-v6-2-375d8e9d7ebf@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
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

Hi Kyle,

On Wed, 2026-06-10 at 09:22 +0800, Kyle Hsieh wrote:
> Add linux device tree entry related to the Meta(Facebook) rmc-node.
> The system uses an AT2600 BMC.
> This node is named "ventura2".
>=20
> Signed-off-by: Kyle Hsieh <kylehsieh1995@gmail.com>

I have some comments on v5 that are applicable here too.

https://lore.kernel.org/all/3d56889c004fc2d11b76ace6033c7ccfb8a37d03.camel@=
codeconstruct.com.au/

Andrew

