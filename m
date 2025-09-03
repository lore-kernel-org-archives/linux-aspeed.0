Return-Path: <linux-aspeed+bounces-2128-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 014B2CA1007
	for <linux-aspeed@archiver.kernel.org>; Wed,  3 Sep 2025 07:11:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cGv0h4cvLz2yr4;
	Wed,  3 Sep 2025 17:11:16 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1756883476;
	cv=none; b=WQxUX6Rdbqd3BDEicfA4Vegp2DQZqyhCGMaUOmWmRAbuzWwEXF0adgFAhQbVDwocBjwmvNXAXKuQOWPVjTMWE3JYTZ3+NfyTyZmaJ6LTYWMu3scDEymxOA/f8j3bTD3BSz9fcVlAvDtUCp1eMlBFGV4pGMVYuemSEfNjBEGxp3MxUutXTcraEqthn4+MgUDMhuZt0iBLFcvLYnBAD0FQGTnxelckRADOYe35Jt+1RDsKGCesH7U7xd1vEyzyutiznzp982M7qrhLoo3OQNhO6TEl0GI+hHmXXhjlVC7I8dBNaLi8xDx+c/qZJ19kZ3Ox4KiG50u3OLq+K6NiNqoy9A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1756883476; c=relaxed/relaxed;
	bh=KTZ1wSbQR1lsYIr30IpvPmakl8nkFVk5+Wo0/3x+lJA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EkUzIU5RizMEWxHUAf4cX12zP9T8W8U4jZl0z+Ip9x4lmZBvvKmtvjZPnKA7gqe+7ztQp+ID+aWKflmQoX8mIQQNFDPzT3w/PR77KfTnTyivO/c60DqpCoZ0DNzxyavqlXB9AlDXEOHfYqKbuj1dtOAArUm/GRYv+rdC89j2ZWhJZ2oMr0q4ssp0Id17QU6Oa1pq06feFRLCB/18+QwxQioMSzmPfNhR91HNWcBVmnxD0RVpLM0jHP92dLCI3yNmXT6sqZFwytWnJ9METCMmaOQpqZeEuBktVLg4ErDP8IF+Y38K4lF920yBNUnRexMm+7fZi3OsrIFTZ3jgSbDFkA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=RDlZ2K3L; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=RDlZ2K3L;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cGv0h18WCz2xgp
	for <linux-aspeed@lists.ozlabs.org>; Wed,  3 Sep 2025 17:11:16 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1756883475;
	bh=KTZ1wSbQR1lsYIr30IpvPmakl8nkFVk5+Wo0/3x+lJA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=RDlZ2K3LBRqdSQCbuZYKoC7FADTYf2w98B+9TyKjmQP1odliXjoKUrejIj+YhKtRq
	 RAtFad20NX7wK6Xy7aZBdCVAnInzCeB7Qu/rzcctuLQV0PrKMsHyElUu8qDTIEi4uU
	 XFF3yhKReLanl7OsJwj0N5zsS7HPrkj7ALSxevskrBYxEcBtKvlZqBvUNm09UKbd8E
	 7Y55v42caluktv8w2YxGXyABRAk0ZnqR0lXrTMGYuIxL6EZo6P9/rzHiDEfHzkIgnS
	 5+7Wfo2IY1dE8YG3wQjFwN2zdGvXojh6AmXHJ7w7Iv74cT9BHT+Qg0NrqlCW7Kp+57
	 TzpGTXI9tK9cA==
Received: from [10.209.99.88] (unknown [180.150.112.213])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 6DF816445D;
	Wed,  3 Sep 2025 15:11:14 +0800 (AWST)
Message-ID: <f3ffa8efe3ba5274faa87e1a6e779f2b2c069a5a.camel@codeconstruct.com.au>
Subject: Re: [PATCH] dt-bindings: mfd: Convert aspeed,ast2400-p2a-ctrl to DT
 schema
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: "Rob Herring (Arm)" <robh@kernel.org>, Lee Jones <lee@kernel.org>, 
	Krzysztof Kozlowski
	 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joel Stanley
	 <joel@jms.id.au>
Cc: Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org
Date: Wed, 03 Sep 2025 16:41:13 +0930
In-Reply-To: <20250829230450.1496151-1-robh@kernel.org>
References: <20250829230450.1496151-1-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
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

On Fri, 2025-08-29 at 18:04 -0500, Rob Herring (Arm) wrote:
> Convert the aspeed,ast2x00-p2a-ctrl binding to DT schema format. The sche=
ma
> is simple enough to just add it to the parent aspeed,ast2x00-scu binding.
>=20
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

Acked-by: Andrew Jeffery <andrew@codeconstruct.com.au>

Thanks Rob.

