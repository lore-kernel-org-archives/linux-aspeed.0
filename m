Return-Path: <linux-aspeed+bounces-3962-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3E4DFF885D
	for <linux-aspeed@archiver.kernel.org>; Sat, 25 Apr 2026 09:40:07 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g2lDP663nz2ynT;
	Sat, 25 Apr 2026 19:40:05 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777110005;
	cv=none; b=bYQuya+g7ya/v2qd9CX2ZfEW6yz95evF0cSRW8A7/CnI89H/Emj7JjT/ue+C7L1u7GLI2F2FZ2/Q6nZlOSvIgkDjZYsru+n5Xwqh1yzT/74HvoJz79N61GmVox0gA13G9cInQOsF9M9Rk7Y7Dg8xXPEbfuhXvEYkLX8DmEhgfE5cScPBZ0M0P6LJ5S2E47CFZpEi0s0SSKrlEfUYb1BinbYf3Ato9Bw5HrwqsYQTWdoXRpEgLU2H1iOMlsapX9LRfIOZGvLjHSAGn1o9nDRRym1NIySMeT9Dr4pKqB52F1h6XzTFlcWMU0FsD4anOX/ug3jIbTMNz4DHfOrh9eAVmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777110005; c=relaxed/relaxed;
	bh=figXkUSrwcrRbxhwSRmzw/loZUUqJx5BTJHJ4wdLmoo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f8IxbRavpyGnkeFP2iuM9PeiNcaJmAJAj2IAhCyqvUxnVaxZWVRRLjtSLqAn1jRdG408nW1zThb9jubxVNUlY1xx8LAjkciK1D3nC+ZJF/z6JTxpBq1kVCELXQmNFqEDiNMzjV9OpaFA9OlQz5aIMDBYuloY1kfajxtJBks0I00qU4BUVd9mm0ZL+PilOkuV/aXyczNqV8BP6GDa03akS7UwD0hyoel3YuGd9aoKKV+8j1rJbbIwI5S5hLEx8t2fGgHZVV32CQRpITMYUt+hPSoDcLLT2kKmGrFckXqrnuZckAgQkQ8yvvtCDQVdNKKMULudhOG0SITRngLcm1OZkw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Tur0dzb5; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Tur0dzb5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g2lDN6Lhxz2y7r
	for <linux-aspeed@lists.ozlabs.org>; Sat, 25 Apr 2026 19:40:04 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id BA46C434CF;
	Sat, 25 Apr 2026 09:40:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECBC6C2BCB0;
	Sat, 25 Apr 2026 09:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777110002;
	bh=hadfq1e14Gw0z8hl3xYnUIRAy4eOpTXE+uwQc3E3bUo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Tur0dzb51y8TATb8JDT+pezGHhqTSQBt0Swj6mLygDhBhkbd2DnhODtFMYJ82MVx9
	 67VHfvDOqkcVDstMrTyeUX70NeYCpcu4Ww1heMSvW5SHvZO3tkmyEOLBS1eIXaARjZ
	 lv2HNVtOXaQryKd/1TlYTClu6RK3QWHkc1WuU9P13UoQ3CXuIp0z2V0PQr/rtq+hkw
	 S67KgSGLqr9nHDCKlm/gHjYOr5RQMOM5vohrQhcxidoc/AnRtbbI42QZsg7qou01o2
	 q9z4kJCONakyfU6UlSdYxZ8gHX3Xwx0tZSb8QPAA4zjEVy2CEHJMDaopmaPWfwbVlq
	 AaODB8KgAVpow==
Date: Sat, 25 Apr 2026 11:40:00 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Dawid Glazik <dawid.glazik@linux.intel.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, 
	linux-aspeed@lists.ozlabs.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, maciej.lawniczak@intel.com
Subject: Re: [PATCH v4 2/3] dt-bindings: mfd: syscon: add
 aspeed,ast2600-i3c-global compatible
Message-ID: <20260425-poised-accomplished-hyena-d2c1a0@quoll>
References: <cover.1777058942.git.dawid.glazik@linux.intel.com>
 <41d66492e1a1d42f6888459288311094c8b7bc51.1777058942.git.dawid.glazik@linux.intel.com>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <41d66492e1a1d42f6888459288311094c8b7bc51.1777058942.git.dawid.glazik@linux.intel.com>

On Fri, Apr 24, 2026 at 10:21:00PM +0200, Dawid Glazik wrote:
> Add aspeed,ast2600-i3c-global to the syscon binding compatible
> lists to document the AST2600 I3C global register syscon node.
> 
> Signed-off-by: Dawid Glazik <dawid.glazik@linux.intel.com>
> ---
>  Documentation/devicetree/bindings/mfd/syscon.yaml | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof


