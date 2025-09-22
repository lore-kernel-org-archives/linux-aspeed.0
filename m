Return-Path: <linux-aspeed+bounces-2311-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9596CCAC5A7
	for <linux-aspeed@archiver.kernel.org>; Mon, 22 Sep 2025 03:56:19 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cVTmy1gQ0z3cYL;
	Mon, 22 Sep 2025 13:56:18 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1758513378;
	cv=none; b=kR8DutOdKcVpNS8fIqXcUnRc1iawqJnRrwTeARssLKiD4wnzc9HkL0UddHRYzNOKvFmtLRwHpfXbhQnC5vk47zoeueKKfq9R75fPtNxxcfatzhD1gOxScVsbwXyRmIEAMLBg/3O7ZYh8i6hCprnx/6rD/ZvWFj7oF1pKSRRV2FtEz3IFvnvIsLmZRgDJRsAQZQap9tIBcufxqklwf9KZm91ixN55d/NjErwZXHc26Afw9BcNlKDknwb4Nrv8cbb4McNrlm6PGe2O4xQFqGyKUgP6kI6fFNf6QtX7wF/Jc9fSzgKMP08QjR9P8VKFdjtbiEwF9UBjbqgaM2mQ8vq0aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1758513378; c=relaxed/relaxed;
	bh=/8Ox722Ja33t+pSAH0BdoPpXXOK9JIvS0e1iSxPH+2U=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Pg2C3gO2TAwd0djkRv+4LzLlSuYC1QP193m1PgmYJK6h8D6OFFkTw9hXeJVCe6FLlDij/AGESTuiX4+kafEQ+RYU//fXsoMYKr48QCUYnXoDlqJaPG8DFZ4rf4u6BwiOF0v7eIH0nge2DxPFgUnn7/uRSPNVM4TQ4es/mArXDZakJ16eyhUGbq+8OErIDw2DwoVw7RNaRVSORZaadHNrCFIXgwZSnIK+5IHwagFusLUqevqaO6a3nYieJ/CI0yq8ufKwLTV0nfGD/c5bbp93trVv4SnTChvA66KNXeM8+dVL583jUJxAvE2D9F7yzG3J4g5Wy78QaM/XdVUOiab5jw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=f3KyClUV; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=f3KyClUV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cVTmx5jFqz303F
	for <linux-aspeed@lists.ozlabs.org>; Mon, 22 Sep 2025 13:56:17 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1758513377;
	bh=/8Ox722Ja33t+pSAH0BdoPpXXOK9JIvS0e1iSxPH+2U=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=f3KyClUVemVid8xs++Nhat2YRNO7D5f4kt1hwz8Rc6Ms1bXQogfg9TTw8ze+AvW56
	 kqurv4wI877YS8ci56AR5EK1Iv5W+tlyd+UOgd/GwQzHeEPMrsfkWgCzFaZ28Skg4D
	 66gFra4qV3kNFgQ1ySPiL5rUrpiBEcbjEChPGf6gVmoIIy6DrrwmO/GHoCzA2iVyMM
	 GhCl3ulhiPmAF9NcJtQg7CKvoVkuhdDCiw+rqyII3hXMh4hY9Xy2J5uTzlB0zu3CMK
	 uGDJHclryKpGdsZPrAQf339YRdF4dDwkzwN4O0JEwg9ZIKkwU3iZJJAwlXNNBJ3t4u
	 qyRE7HDROx09w==
Received: from [192.168.68.113] (unknown [180.150.112.213])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id A13DD64731;
	Mon, 22 Sep 2025 11:56:16 +0800 (AWST)
Message-ID: <0fc79e55e5fc0f8a43586ac3f90599b8f2a6c817.camel@codeconstruct.com.au>
Subject: Re: [PATCH] dt-bindings: edac: Convert aspeed,ast2400-sdram-edac to
 DT schema
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: "Rob Herring (Arm)" <robh@kernel.org>, Stefan Schaeckeler	
 <sschaeck@cisco.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley	 <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date: Mon, 22 Sep 2025 13:26:15 +0930
In-Reply-To: <20250919195326.2079446-1-robh@kernel.org>
References: <20250919195326.2079446-1-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1-1 
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

On Fri, 2025-09-19 at 14:53 -0500, Rob Herring (Arm) wrote:
> Convert the ASpeed SDRAM EDAC binding to DT schema. It's a
> straight-forward conversion.
>=20
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

Thanks Rob.

Reviewed-by: Andrew Jeffery <andrew@codeconstruct.com.au>

