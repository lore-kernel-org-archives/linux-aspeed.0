Return-Path: <linux-aspeed+bounces-2487-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47526CCD195
	for <linux-aspeed@archiver.kernel.org>; Fri, 17 Oct 2025 06:20:05 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cnvnH4n3gz2yhX;
	Fri, 17 Oct 2025 17:20:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1760682003;
	cv=none; b=VrmgCi0O/KrekTg344Ac1eWgfG6ZYBhgj0CwwjzAbqUM/qzJ5he93zpxSILcb/NbGlkWvNWY5aDyiCIMETFwLxPuRBaXn201rf0ONSagwp6el0SuMO+XfU2Me3RX0DEIevQ2ANVPzm/plJfNimwwHTFP53ufx15L0EL0mNp2vtRhk3UwALYjGBur5DRx3dL1grenjZXZ6COKvsfFRSAWNbzxNVtJMSaVAMC6PSmuHrMUHnfOk/A8Nqaduy3V1GkMejzh3Nt8N8ezjBZDVXspgN+5E64dVwo9ZtaG30YMEAPfrkLGCBieuhRT5KM09kVl7ajjN14lD63uyXrzxI39qg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1760682003; c=relaxed/relaxed;
	bh=LuLa4eedzbUwTpnlaZPmlkTyolIBXjzmkHFoMfgfTB4=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=YMbPpf1CCdsi/M2soS2xdnF40ePm7YNyf0Lpsz2tA7V0UYqpb0BdXzAtn1fCo4iD/BKTeVgpZq/GzqCM5jjwWkkWImS5FC2xjxV3AuNz4xScAXjbx1t9GtNYabwnS+2j28ltSKL92SzPO/B88e8StbljaecasEA3VGaTs7IsUBk4ogt8fQxL2WSigYyodVVdtE4rIcaLT8r1OZzolcr9Z3hlu4sK73tHrJ4PSLKp5ytJjvW29Ye3NMqwFMk3N6ts2t3LWvrWHICqtyTCmLg4e9D/LZZJZxTGXUZt6hJnOcO7pgV99O+66ZW/CNpxoDngC6z/hJA0yz1tgszmSjgRsw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=GrJehQx+; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=GrJehQx+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cnvnG5TCxz2xQ0
	for <linux-aspeed@lists.ozlabs.org>; Fri, 17 Oct 2025 17:20:02 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1760682000;
	bh=LuLa4eedzbUwTpnlaZPmlkTyolIBXjzmkHFoMfgfTB4=;
	h=From:To:In-Reply-To:References:Subject:Date;
	b=GrJehQx+sir5LqSm5whp4UV/1rcumxx6hSvrVCa2Fp8sbksHf12BtcyNy+RUFWzxj
	 yNMZ+60tOqqyITTdKfE8bCVdac927tJyq4PwkPjScJxb8d9eEjgKATv9vR9XdRw2zS
	 jRFAqy+gF/k0j3WxY4sSgIM+01MQz9yHeCH1aH1TOUl1bmmnM4s8YCwzXOrk/lGA1T
	 pSvsjeKNKtleawZWuq/0ASt3gbcs7JUA/pQhRpUqr4nzAkYiyaU8kVFIxAmoq0OX0R
	 WDo6zNhPN5+mli9NeEkORugtSF6d3zaX+qEzhExf/aHJAcJNak0n/dQTimSQQ8zFCh
	 yvAs4Q1Ycl84g==
Received: from [127.0.1.1] (unknown [180.150.112.213])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 12B3A6477A;
	Fri, 17 Oct 2025 14:19:59 +0800 (AWST)
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Fred Chen <fredchen.openbmc@gmail.com>
In-Reply-To: <20251015143916.1850450-1-fredchen.openbmc@gmail.com>
References: <20251015143916.1850450-1-fredchen.openbmc@gmail.com>
Subject: Re: [PATCH v4 0/7] Revise Meta Santabarbara devicetree
Message-Id: <176068199902.287212.1469611481983268246.b4-ty@codeconstruct.com.au>
Date: Fri, 17 Oct 2025 16:49:59 +1030
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-cfd50

On Wed, 15 Oct 2025 22:38:56 +0800, Fred Chen wrote:
> Summary:
> Revise linux device tree entry related to Meta (Facebook) Santabarbara.
> 
> Change log
> v3 -> v4:
>   - add blank lines between nodes for readability
>   - drop changes to already defined LEDs
>   - add gpio name debug-card-mux and FM_MAIN_PWREN_RMC_EN_ISO_R
>   - enable amd apml interface
>   - add eeprom for prot module
> v2 -> v3:
>   - remove mctp node label
> v1 -> v2:
>   - add 'bmc_ready_noled' LED and update commit message
>   - add sgpio line name for leak detection
> v1:
>   - add sensor nodes for extension board
>   - add mctp node for NIC
>   - adjust LED configuration
> 
> [...]

Thanks, I've applied this to the BMC tree.

-- 
Andrew Jeffery <andrew@codeconstruct.com.au>


