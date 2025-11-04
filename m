Return-Path: <linux-aspeed+bounces-2728-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 476D8CCF9E3
	for <linux-aspeed@archiver.kernel.org>; Tue,  4 Nov 2025 04:08:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4d0w0y3SNxz3bf2;
	Tue,  4 Nov 2025 15:08:18 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1762229298;
	cv=none; b=TWdFwB1D3Wpy78HtUi38mKiIK0z6IIWlXA3JbHoShdW74M9558YbQlERzxKUEO73LKcBa4/Tjqj3ywQJsm2hbMwXNaGo3O/bdoRJVNmxgi7oEXdb2umgClcKpne93gO+GyRLM6M7wcB4dY5S1Rseh4OL6GeikmzkmopETgoYTuJqabTeBKdx6EtCu5ViTAIa7juY8Hyhj7gjI0uh8FOLOL3cxbWQOFr0e+ZFcQ8kdKSUwafJDgo7p67ZzpcuVreAbrm5a6RL80ei3tj5GvsgVheAjvgk8MCbcAxJrFIzhzNWYlWTSVT/mD8BVCHlfl5ldWkSaWkhzbiZ95CAtHwifw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1762229298; c=relaxed/relaxed;
	bh=SCzuRbK010iCV7uM5d9o/fnRKEhVAKqhq5VkVQV9Jb0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C1IGRBJqc50J0HOcinvWShu75RZlfBatrrJwk0g3CUDJkVqlXkiL4yVI5GxpLKpbSWghJWnkKIw1NTDRsVAfnZmNpW12tgMZYj/CWiRFeTW4YXZqvgnwC/9KW9YQw5xPOE8cKmu8+QWK2QSQkeTBNAaFImuD2qCHrHHKpKk7i4FeHppI5LgQt37k8/JnYTOHZqRi8Gqi/lKKfdThJlSYtYzPkCKL8mdiDKQkC/xseygxpOtX/+Z9kaVbJQ3CbgdR2R63E+sDGllRXgMGseGQpU/N6mhhCHMGVGTEfvq7HL1SJzEUUuvpiIfa0uyCEbu40xqV3u/QcQ/CIk5WRAGD4w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=cECTuwET; dkim-atps=neutral; spf=pass (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org) smtp.mailfrom=lunn.ch
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=cECTuwET;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lunn.ch (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4d0w0x3Y1rz304H
	for <linux-aspeed@lists.ozlabs.org>; Tue,  4 Nov 2025 15:08:17 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=SCzuRbK010iCV7uM5d9o/fnRKEhVAKqhq5VkVQV9Jb0=; b=cECTuwETLawdqhDEoiTBQY82TY
	RbZpkUtyzgw/JFQbrm9aQInyZbVWJaQl77CLk6CrImMO1gufct+nZJgh5ZGrI5nSviqcRr1JL//iZ
	kGR3rYoFHiYAZBGa5H5AITadeGMJw8s06U05kxtiWYiu8JeV03/BMQa+1Xe6VjqCming=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vG8Ks-00Cqya-Cq; Tue, 04 Nov 2025 05:07:58 +0100
Date: Tue, 4 Nov 2025 05:07:58 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Po-Yu Chuang <ratbert@faraday-tech.com>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, taoren@meta.com
Subject: Re: [PATCH net-next v3 1/4] dt-bindings: net: ftgmac100: Add delay
 properties for AST2600
Message-ID: <cf5a3144-7b5e-479b-bfd8-3447f5f567ab@lunn.ch>
References: <20251103-rgmii_delay_2600-v3-0-e2af2656f7d7@aspeedtech.com>
 <20251103-rgmii_delay_2600-v3-1-e2af2656f7d7@aspeedtech.com>
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
In-Reply-To: <20251103-rgmii_delay_2600-v3-1-e2af2656f7d7@aspeedtech.com>

On Mon, Nov 03, 2025 at 03:39:16PM +0800, Jacky Chou wrote:
> Create the new compatibles to identify AST2600 MAC0/1 and MAC3/4.
> Add conditional schema constraints for Aspeed AST2600 MAC controllers:
> - For "aspeed,ast2600-mac01", require rx/tx-internal-delay-ps properties
>   with 45ps step.
> - For "aspeed,ast2600-mac23", require rx/tx-internal-delay-ps properties
>   with 250ps step.
> - Both require the "scu" property.
> Other compatible values remain unrestricted.
> 
> Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
> ---
>  .../devicetree/bindings/net/faraday,ftgmac100.yaml | 50 ++++++++++++++++++++++
>  1 file changed, 50 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml b/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml
> index d14410018bcf..de646e7e3bca 100644
> --- a/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml
> +++ b/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml
> @@ -19,6 +19,12 @@ properties:
>                - aspeed,ast2500-mac
>                - aspeed,ast2600-mac

I don't know if it is possible, but it would be good to mark
aspeed,ast2600-mac as deprecated.

I also think some comments would be good, explaining how
aspeed,ast2600-mac01 and aspeed,ast2600-mac23 differ from
aspeed,ast2600-mac, and why you should use them.

	Andrew

