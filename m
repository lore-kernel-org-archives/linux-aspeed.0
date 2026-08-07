Return-Path: <linux-aspeed+bounces-4644-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5854C5AC7A
	for <linux-aspeed@archiver.kernel.org>; Fri,  7 Aug 2026 07:23:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hGbH423K2z3by8;
	Fri, 07 Aug 2026 17:23:44 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786087424;
	cv=none; b=AsIjADMa9OG+SjhZXhNJT209X5+3rc7x/uz5+h9V5f4EJTQu7RFVGzjh7S81u0otIpOSaZM7TmsCdChWKydxzK2alBFBQyrrwJCBMcqTk8sj692MQEaYWT9rNcF+zt45FCq/TSINvvjiat4//xz3nvzDSa4kVGZd9SbVhNb/TA42SWknKLK0kMucEaTwYUl9jeGjI+Jmq70kVOKc4b1ClOmeLXpIgAozPFtxIsimfjgVqCYXKAuq2EVUqEikm8wZBjKETkfCKcmQMuf15sn158wkIxx62xDxMhNWaaIMvlsr1mKHbNSzbmU52468R84xDJGH+oG0q4zL9uYzQsIxDw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786087424; c=relaxed/relaxed;
	bh=AgQPRr6KO6f+5jgx8UafJjTGJrvaC3/Te3NzsCkfesU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kY4ADM9WVsfWwWNwUOfMq3LRJGV+jr4PbVIxsqQfqexiQ40grtWbQSsPu6HkulwQsPbPVsiX+y3soEyY+mbxoD3ZTirD49T4R2cY9QcsZzt+P58aMQAqW3I7k/hUPwCeirBCPXCeiJMXXGGbbnMRmOrQTTT1DjOnKFbu7dRIzLAY0+2lS6BC8B5ba30DRy0ulEqai04WzE+gxwBd+/tRUbUcmFg8a+gJzVOH8ygghPB8KEGIpbeAGM6mWljV5g4KcU7yUVLq4hP8CyXgeu0P1b1pP1nU+Pxt7PcviMWBeaNp4UesKfmScy0XXJIGeynk9AWUrjwTYGVaXvAJVu3gvw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CLij02BS; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CLij02BS;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hGbH31swRz3bxM
	for <linux-aspeed@lists.ozlabs.org>; Fri, 07 Aug 2026 17:23:43 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id EA9BA40810;
	Fri,  7 Aug 2026 07:23:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15EB01F000E9;
	Fri,  7 Aug 2026 07:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786087419;
	bh=AgQPRr6KO6f+5jgx8UafJjTGJrvaC3/Te3NzsCkfesU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=CLij02BSdOzAHBhHBATYyrVi9hkxsqlYz4VIYJ+tLIwDOusBpIeEQ6nsvCbMmewrW
	 HzOWWFbkb2ioc+QJoowwcc5Iy/emL5WdxemjWy7NTS9alinUOyAX1FV9XcGtj2+Fm4
	 uOkegAHxaeY8ov8h3m6b5FkotOYK7ZyLC3bY8umE587jIWR07AkjBrEmbXDhUDnkwF
	 phevrPP/W5uqtvfeumb61rtIwEX7Ln7z4IHP2tC4EpfiqEJLE4I664YL5lGDCcyCP+
	 OvX56TuEiitZwE6pduxT7YInlF2VB3wmC8MRxs/FyjKtUjTYq7zjp35U029Rjv6n6f
	 tU12iXfiDJFqw==
Date: Fri, 7 Aug 2026 09:23:35 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: =?utf-8?B?R3LDqWdvaXJl?= Layet <gregoire.layet@9elements.com>
Cc: joel@jms.id.au, andrew@codeconstruct.com.au, lkundrak@v3.sk, 
	devicetree@vger.kernel.org, gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, lee@kernel.org, 
	andrew@lunn.ch, jacky_chou@aspeedtech.com, yh_chung@aspeedtech.com, 
	ninad@linux.ibm.com, anirudhsriniv@gmail.com, tan.siewert@9elements.com, 
	linux-serial@vger.kernel.org, mfd@lists.linux.dev, linux-aspeed@lists.ozlabs.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/6] dt-bindings: serial: 8250: aspeed: add ast2600
 and aspeed,vuart-over-pci
Message-ID: <20260807-ginger-mushroom-of-reputation-bbb7c8@quoll>
References: <cover.1785932211.git.gregoire.layet@9elements.com>
 <52d5bce1cf8ec3ff0b27e7313655cf7ffa2236b5.1785932211.git.gregoire.layet@9elements.com>
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
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <52d5bce1cf8ec3ff0b27e7313655cf7ffa2236b5.1785932211.git.gregoire.layet@9elements.com>

On Wed, Aug 05, 2026 at 02:19:48PM +0200, Gr=C3=A9goire Layet wrote:
> The ASPEED AST2600 has 2 Virtual UARTs accessible over PCI.
> The ASPEED AST2600 can be used as a PCI device.
> 2 Virtual UART can be exposed to the host via this PCI device.
> These are 8250-compatible register sets and can be used to have UART
> communication between the PCI BMC and the host.
>=20
> This boolean can be set to specify if a VUART is used over PCI. A VUART
> over PCI needs a syscon phandle. The syscon gives a regmap to the SCU,
> which is used to set the enable bits of the PCI device.
> On the aspeed's chips, the clocks phandle already points at the SCU node.
> But deriving the regmap from the clock provider would misuse the clocks
> binding. An explicit syscon phandle states the dependency directly.
>=20
> Signed-off-by: Gr=C3=A9goire Layet <gregoire.layet@9elements.com>
> ---
>  .../devicetree/bindings/serial/8250.yaml      | 42 ++++++++++++++++++-
>  1 file changed, 40 insertions(+), 2 deletions(-)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof


