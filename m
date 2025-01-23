Return-Path: <linux-aspeed+bounces-546-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B31E9C0218B
	for <linux-aspeed@archiver.kernel.org>; Thu, 23 Jan 2025 22:12:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YfFYB61qZz2ytN;
	Fri, 24 Jan 2025 09:12:14 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=147.75.193.91
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1737670334;
	cv=none; b=axBftvnrBvIn7KhUPFt+7HZ5whq0XkIs0T/4uoBR+QZeKoLSO99cH3TjlOI04rxczJ0HjUl8z96ab3XsFeHdI0KdKnJZuO/mT5JcpVQPWVzBUXA7e7hya2nCnagqgF9QGkS4h3BD6aXY7Yj/TDJ/1N2pLm7SnfiwET4ANNtt751jqz8x3SsYbNTpteevPVEGnWn6gaaxejoWdCYfMt5jP4HoKrdMPYHazGQbLqzLfspa9oEnx0HZOApihbLzFgyMhnvAWbXbWE5wE+u2gvOuK65Qb7MntVs1zAx5T/Fm0X87EM98nQ2Yc4Rd/XDGbQMb1yCxHKqMjWNyHpfQc5NulQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1737670334; c=relaxed/relaxed;
	bh=LRPyClg3EsQbuPGoIm4DyxtDIXG2VDQIOtJhIA48rqk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kxNO38hsh2S8u4cIuGDTNQ9jEHri9akxHC8m3yXrGSScXu1ofMxdZcNJZT5Tuyq7KchJzDNxrjUasfx1aWQiBhuqPP5Ji+0+FH7MYfNOc+3pg2R6JNbpmnddoB0ensB5JqCrG/w3UPuk0148muv9znwh1q5jIvrasfc4NbbN22Nu69VzP23q1m821fEEt7ykzxwxtsKaq77S1D5ALQAVNK4X9at26w4fb6dC5DI2D6IsodMupfOnUPhJNkbKGLIhscLJqHEku7GBWU0r82NjBttYEECA05HvzHTc+mgjWy2PIHl8TLudAC3nlazIQCd+XkBRUiDDM14IroWohpRjQQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=pS0PydAP; dkim-atps=neutral; spf=pass (client-ip=147.75.193.91; helo=nyc.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=pS0PydAP;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=147.75.193.91; helo=nyc.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YfFYB08Ftz2xYg
	for <linux-aspeed@lists.ozlabs.org>; Fri, 24 Jan 2025 09:12:13 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id C791EA40B1F;
	Thu, 23 Jan 2025 22:10:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D677C4CED3;
	Thu, 23 Jan 2025 22:12:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737670330;
	bh=h5zYZEeh2fayA+qgYt1ROno/TFyCfT21k9zimU507Dk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pS0PydAP+A2YJMSiI8R5iPpvEnHyM7oUr40s3uHQxbFxq6iXZ498P+qYTBYL5FiG9
	 98ffwKSrAFQvn9NDtjAD0K87PpxCpCsK6QXof+baFrDGreCApwkNQ2vmEuqNXQu+Kv
	 t6pyoV7HiNuLnpxeSUQPHwzR9n4Af9dU6mCCXwY7HXLAbXf+0xDZZfq8IFEW797fuL
	 Wvc5n0H8yOZaKN4VElcrUqH4XdlT2AfYnkHZYFINZC+3L3iS8PP6SfaN/r5TJWuik1
	 wjpwY2Kn/I7M3bLekd2YYYhV8/+KYrxRXUJXBzyBldxEU0xqvYvokHfM/QoJLFgqRS
	 VUARXO7KPHoWA==
Date: Thu, 23 Jan 2025 16:12:09 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Ninad Palsule <ninad@linux.ibm.com>
Cc: pabeni@redhat.com, davem@davemloft.net, edumazet@google.com,
	conor+dt@kernel.org, kuba@kernel.org, andrew+netdev@lunn.ch,
	joel@jms.id.au, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	krzk+dt@kernel.org, eajames@linux.ibm.com,
	andrew@codeconstruct.com.au, minyard@acm.org,
	openipmi-developer@lists.sourceforge.net,
	devicetree@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v6 02/10] bindings: ipmi: Add binding for IPMB device intf
Message-ID: <173767032899.448455.5833909744401276024.robh@kernel.org>
References: <20250116203527.2102742-1-ninad@linux.ibm.com>
 <20250116203527.2102742-3-ninad@linux.ibm.com>
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
In-Reply-To: <20250116203527.2102742-3-ninad@linux.ibm.com>


On Thu, 16 Jan 2025 14:35:17 -0600, Ninad Palsule wrote:
> Add device tree binding document for the IPMB device interface.
> This device is already in use in both driver and .dts files.
> 
> Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
> ---
>  .../devicetree/bindings/ipmi/ipmb-dev.yaml    | 56 +++++++++++++++++++
>  1 file changed, 56 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/ipmi/ipmb-dev.yaml
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


