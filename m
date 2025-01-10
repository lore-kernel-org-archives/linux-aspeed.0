Return-Path: <linux-aspeed+bounces-427-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C633DE77188
	for <linux-aspeed@archiver.kernel.org>; Fri, 10 Jan 2025 16:03:04 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YV5zC2pr9z3c17;
	Sat, 11 Jan 2025 03:03:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=139.178.84.217
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1736524983;
	cv=none; b=hJzJOjQ8ZKEnOvCgM1291v72EoHZyKtWODKVpZX9vw/R+cvB/rUZOIMyXcrGAOFwnkTuw04OO61oocau+M83L3YVz7HifyFyb2nk38QAz7XaJ0x67TgPgNeRhlBGvFFUuJeqgbDkxYs60aA8oRGKfcwbGHOo/AwCZ9u1zYJU3G+Mh+7Ld9f/PgO1DB3dBT5RjwIRNL7wvSiNAi+QZOc1JFogUxDkr3AxIikrCuDuu0DWDFxwxwo+MeTH3BUZDGsUkyCGRocWd636LLtmm8gieZ4EYXjWzPzq1BG3XEOteIDrJgadAj1CBpi3s9S+KZBXEc5ILBSQczZlHFVaC11u7g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1736524983; c=relaxed/relaxed;
	bh=WE1mjwbjPoFLC+ZzgjigY9CirLmrXWGlf1v1smKl6Wg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O8ju1Ut4fnciltUjH5wGKUyeOCcq9fK6VUmYIFmyaPTjhMfn34jMXg3UcH67Tds+F6r6bVmqLV8lcREEsGE25suKZneDkpUD/QAxCOczbUQc/9pMAt/rBPPgJ5lBIlzqn1C5JBhZBM5POEzK5puiEz4xDHAdyl85hwTHYXnK1b68NOGmVIpjEqon6jUfRIB6tOdIlA6PlicOAXpd66oOys1IdNuyYUPYkVBzu1r5N3f3YK8+hHEHnsQf9+EA0B7A0r74Y3BZoBwfPNUchBl0+Nl3Eo4des3MuoMMMfiELuPka2ao7iadk9rhJfrEiOP6uzhryG/O2fAAG3uORMxCjQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ni5EALDs; dkim-atps=neutral; spf=pass (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ni5EALDs;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YV5zB2MyLz3blT
	for <linux-aspeed@lists.ozlabs.org>; Sat, 11 Jan 2025 03:03:02 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 4B5805C0674;
	Fri, 10 Jan 2025 16:02:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3CD1C4CEE1;
	Fri, 10 Jan 2025 16:02:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736524978;
	bh=5diCFIWZuIJV4OjMCTWDxa0Zly+MOIMNEFHwJP7l1Sc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ni5EALDsWJZer0hLZHbaLS+k6dsytqsVi5PzwKotztyPzlieVlJX0W4MSNwPuJjaY
	 gqE0uYsSBccFOY1YUJXoe6I/pAGCFtHWbUwP/sOvjjkE/TEee86FlejI32+Ql0hVvy
	 6ecrvKY/zIO99leBuMepgyseEnJEAzOi3wiGG2MZPihYHNNfnZbOkPZXqPyEJwMZBf
	 Z0h2518+suWkTNpqYocRGSwgPGjp3w06qGmJPi6m3OXqvd/hrebnb+8C2ZajQgeIQ0
	 toIYd7K8WJoozZcs+9CzqOG1FnT3ydtowvi9edIUvgI/E6I4OOhM3MaQEAE8R+hXUu
	 aubW6LpC00vZg==
Date: Fri, 10 Jan 2025 10:02:56 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Ninad Palsule <ninad@linux.ibm.com>
Cc: openipmi-developer@lists.sourceforge.net, netdev@vger.kernel.org,
	joel@jms.id.au, conor+dt@kernel.org, devicetree@vger.kernel.org,
	andrew@codeconstruct.com.au, kuba@kernel.org,
	linux-aspeed@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
	andrew+netdev@lunn.ch, eajames@linux.ibm.com, minyard@acm.org,
	krzk+dt@kernel.org, davem@davemloft.net, pabeni@redhat.com,
	linux-kernel@vger.kernel.org, edumazet@google.com,
	ratbert@faraday-tech.com
Subject: Re: [PATCH v3 01/10] dt-bindings: net: faraday,ftgmac100: Add phys
 mode
Message-ID: <173652497637.2952052.6627595246829829775.robh@kernel.org>
References: <20250108163640.1374680-1-ninad@linux.ibm.com>
 <20250108163640.1374680-2-ninad@linux.ibm.com>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250108163640.1374680-2-ninad@linux.ibm.com>


On Wed, 08 Jan 2025 10:36:29 -0600, Ninad Palsule wrote:
> Aspeed device supports rgmii, rgmii-id, rgmii-rxid, rgmii-txid so
> document them.
> 
> Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
> ---
>  Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


