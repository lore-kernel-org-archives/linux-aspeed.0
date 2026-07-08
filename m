Return-Path: <linux-aspeed+bounces-4435-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F3F3C43458
	for <linux-aspeed@archiver.kernel.org>; Wed,  8 Jul 2026 16:47:07 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gwPBx6qS0z3078;
	Thu, 09 Jul 2026 02:47:05 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783529225;
	cv=none; b=ciwCdk9tKDNdrjojv1z4wuwYzn3AIsannL8OfH/Kpmh9vq84sXvNMQ1Kjp/ARXu8tCVy+i3lrYSQRV50+3zcvEYZJwaNstj32a7r5xHYyZ7b9HzGtkMmK/tvqgvb5KuD+Dujw6YiMySG8kF0AI490FuNRYq2fVijaJycC+HRzBvpzUZfyzBaoNOruC0c54FT56PBWdx6YfikYb8Jcf+XWkJSO8bWdLDMq8b9WVZpehurKsNO0IDziLyMNdVJf235oQvsxmh+Us+DJsce81jHYxCLewqWnIGPON6djCJyo3N+OeJf7gQ5N005I9S/XkdCEcAa/AWuInpwtHHsxcEwlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783529225; c=relaxed/relaxed;
	bh=y96gfCnZ28npS8MYymCLzvmBAFbrMX4D89vuwa0iaks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lU0jLKDNBctKoyyIyLjG0rS4ucxsqvlLsr5wSffxSK9brW/QM2hi4xRcInVB5afh5mjqGtn4xAMIKHcSt61rX5FD/bQm46g3rABHttL0OEXloXBCJxdp5dyRMNzuL0k3IFcBDCKwGMxUkLJ3/Lk+wpJlYaEuh50AnKbeUDChU2FpG2HCfI8pjfTvM3Zdr6lmKBxZUpwXpDt1/M8mTqgjFiwX3gyaOFZXB1JPE7q37RrrJvawE3Rz40zMlvy1iBhpIgw5qLfab/DMuPs1kbWCXjgAHFu4l9FEPhGKyjg1VE/oKglAmYS/cXmPue0CAima1eifOSIwhcdfSTs7N6kNFA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=wwRud+pN; dkim-atps=neutral; spf=pass (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org) smtp.mailfrom=lunn.ch
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=wwRud+pN;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lunn.ch (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gwPBx12FQz2xll
	for <linux-aspeed@lists.ozlabs.org>; Thu, 09 Jul 2026 02:47:05 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=y96gfCnZ28npS8MYymCLzvmBAFbrMX4D89vuwa0iaks=; b=wwRud+pNiUjMFw2nFYsQhA9lUG
	Sc8PGjb1TVym9+IDgG+iJSxJqhOVfDPJl8yd9kq7wNgxNyX4fMbLPF3GXcMBs/Tp+6RYwJ4tX6GGM
	gbmimnd9sNh5iub/OgWU0EK6S/vkVzfJAFrE0z8je6PrBVeyrZg/ew2hN3owEJbD2+8g=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1whVQC-00BM2v-3I; Wed, 08 Jul 2026 18:46:52 +0200
Date: Wed, 8 Jul 2026 18:46:52 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: =?iso-8859-1?Q?Gr=E9goire?= Layet <gregoire.layet@9elements.com>
Cc: joel@jms.id.au, andrew@codeconstruct.com.au, lkundrak@v3.sk,
	devicetree@vger.kernel.org, gregkh@linuxfoundation.org,
	jirislaby@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, jacky_chou@aspeedtech.com,
	yh_chung@aspeedtech.com, ninad@linux.ibm.com,
	anirudhsriniv@gmail.com, linux-serial@vger.kernel.org,
	linux-aspeed@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 4/7] serial: 8250_aspeed_vuart: add VUART over PCI
Message-ID: <694c7c37-fb42-4994-93eb-04ed4ae299cf@lunn.ch>
References: <cover.1783524645.git.gregoire.layet@9elements.com>
 <28c6e7c493559feffc7e6231b0a2f0b73b7fda41.1783524645.git.gregoire.layet@9elements.com>
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
In-Reply-To: <28c6e7c493559feffc7e6231b0a2f0b73b7fda41.1783524645.git.gregoire.layet@9elements.com>

> +	if (silicon_revision_id == AST2600A3_REVISION_ID)
> +		rc = regmap_update_bits(scu, ASPEED_SCUC24,
> +					ASPEED_SCUC24_PCIDEV1_INTX_MSI_HOST2BMC_EN | ASPEED_SCUC24_MSI_ROUTING_MASK,
> +					ASPEED_SCUC24_PCIDEV1_INTX_MSI_HOST2BMC_EN | ASPEED_SCUC24_MSI_ROUTING_PCIE2LPC_PCIDEV1);
> +	else
> +		rc = regmap_update_bits(scu, ASPEED_SCUC24,
> +					/**
> +					 * The bit 14 is reserved in the Datasheet.
> +					 */
> +					ASPEED_SCUC24_PCIDEV1_INTX_MSI_SCU560_EN | BIT(14) | ASPEED_SCUC24_MSI_ROUTING_MASK,
> +					ASPEED_SCUC24_PCIDEV1_INTX_MSI_SCU560_EN | BIT(14) | ASPEED_SCUC24_MSI_ROUTING_PCIE2LPC_PCIDEV1);

checkpatch should be warning about these long lines. Traditionally,
the limit is 80 character lines, but recently 100 has been accepted by
some subsystems. The exception is when wrapping the lines will make
them less readable, but i don't think that applies here.

	Andrew

