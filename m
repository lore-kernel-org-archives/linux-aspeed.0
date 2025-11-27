Return-Path: <linux-aspeed+bounces-3005-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7A6BD116E1
	for <linux-aspeed@archiver.kernel.org>; Thu, 27 Nov 2025 00:09:26 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dGxcj1Mhyz2yr4;
	Thu, 27 Nov 2025 11:09:25 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1764202165;
	cv=none; b=gG+hrPe3AIaTkh+GaAMSZMzXE7z6jLO76JuJlgRE1hLhkKxALvyL8W8aTt7noqagT7UTGMR0jVkQ7J0mDFAP+VptUgk6Z7RDNIWbZJdlI5mkHD6JDTSyKI+SnbO3owMm6iv4dTUZAPupLRWLXYFqHZp3S90bs60vXdeklgfXR4kNrCcdtVPAnQkfYNVsVQG2XGkB5sp8MupxrPgMhnyN1lTFKKpy0TlwW4MuqlY+XAi1JXH5rTJeGcjbucod/09ZAutM96pgxBF3N2ZVZ6LTTzZcGjXp5CjF81afbsMfdUQlT6TH4Dw++jv9qknPcz6tKgsNlejVeVnr6xyQ/ujQyA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1764202165; c=relaxed/relaxed;
	bh=YSyiRW1FlOenglm2u/M08PCHR36GOfF+K01IO6BA5Ig=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cmiunrGI4JeStfDtRXfYwMYgSD9FRPGRUedJzY5lSYa5s8+m/fwREtnYfTeRKHytB4Sh3Opo2/ywgttgQzMi6hpzu4WJWaRuUCQzq+SMUbVXcpaboW07gcQOHuH8lHdnrFfXdd++decf9k6tqz61J5pBOIVNM85stkSEU2ygyItVievZoOne8PdLasn5lOcFsWEjNByL9p7r+IkQkbnwF4bnVkzSHSJyILPtDX2KMo6EsrlmgNLqxD5ZLZu0/nOeZSx232Smy1PO3yQbY9pRpzSkGExs/c+ET1H1ReaMoIvyoQj3Tidy5/kpIiqW/I/zs0Jtzbzvw0x1McmK1znGWA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=GE6RTA37; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=GE6RTA37;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dGxch07yWz2xP8
	for <linux-aspeed@lists.ozlabs.org>; Thu, 27 Nov 2025 11:09:23 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1764202163;
	bh=YSyiRW1FlOenglm2u/M08PCHR36GOfF+K01IO6BA5Ig=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=GE6RTA37oHwxcE3MmkkWQlnKhuyPc50WN4YCD/uIHWekOMcWGHMBIGnpSh1ZsGjMS
	 E02qnWPiyPhJhhkwPiSyk78cnsjwNYsrG/kw6LC3VY9bABUGr+oDRPu56YGv/jXufh
	 VYNSHsscnTxRPnQfhJ/i9BgcRJoGkmvZgZ+ToNgyGbR1Nc9HahM2nUq2V8wK48tR4O
	 dcrbhTSJ/nK9Fiu3RFwsJ4ls6ouGdG3x0Kf1OjgXsp51P7vQoIY5ldZcNuvkUaEW38
	 NE5NhVKc+DLl0fz7jxGireNzjoHA4gwQ8YodAMcnzgRFLzKN5ilGl4ot+C47c8FAcm
	 6jgH2SBAy/bvg==
Received: from [192.168.68.115] (unknown [180.150.112.38])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id D1CE36561D;
	Thu, 27 Nov 2025 08:09:22 +0800 (AWST)
Message-ID: <f1a18e7b8deb5987164b4506f8400dcad67a8862.camel@codeconstruct.com.au>
Subject: Re: [PATCH v4 2/2] dts: aspeed: Add a dts for the nvidia msx4 hpm
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Marc Olberding <molberding@nvidia.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski
	 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joel Stanley
	 <joel@jms.id.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date: Thu, 27 Nov 2025 10:39:22 +1030
In-Reply-To: <20251124-msx1_devicetree-v4-2-a3ebe3110a67@nvidia.com>
References: <20251124-msx1_devicetree-v4-0-a3ebe3110a67@nvidia.com>
	 <20251124-msx1_devicetree-v4-2-a3ebe3110a67@nvidia.com>
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

Hi Marc,

On Mon, 2025-11-24 at 15:14 -0800, Marc Olberding wrote:
> Adds a dts for the nvidia mgx pcie switchboard reference
> platformi hpm. This is a dual socket granite rapids based platform.

I was looking to apply this, and set about tweaking the commit message
in the process, but the more I tweaked the more I felt I needed to
tweak. So rather than do all that myself, I'll ask that you work
through these requests :)

The things that I'd like addressed are:

1. The subject prefix needs to begin with "ARM: ", so:

   ARM: dts: aspeed: ...

2. I'd rather stick to formalised naming and capitalisation, so NVIDIA,
MSX4, and HPM, Granite Rapids etc

3. "Add a dts for" in the subject is a bit redundant, as we already
have "dts" in the prefix. We can trim that out:

   ARM: dts: aspeed: Add NVIDIA MSX4 HPM platform

4. "HPM" hasn't yet been expanded anywhere and it's still a mystery to
me. Can we unpack that in the commit message?

5. "Adds a dts for ..." in the commit message is self-evident from the
patch. Rather, can you please talk a bit more about the purpose of the
platform? I'd like to see discussion of its use cases and any
interesting points of design or implementation.

Cheers,

Andrew

