Return-Path: <linux-aspeed+bounces-46-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B37AD5B845
	for <linux-aspeed@archiver.kernel.org>; Mon, 28 Oct 2024 23:55:38 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Xcqyc6BFlz2yFJ;
	Tue, 29 Oct 2024 10:55:36 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1730159736;
	cv=none; b=M5XzCdbJrBqzchHpc8vVEksFDuXQrGb+kBv2UNoiHj5VC98T9lMGUEsXDEEV1NoIHJ2lAIa6YtkhngdYs3UhBZL//PUYKaFcpdfo+a2z/ZAAfT+twJrPMiCNvNACXSlgfm0xfJgA5O5Sr7qfMUDZZnfguW2Hp6P4d3H/NNkrqR2aC/ld5w4rIGVPD//mzBu3yOv6pHp+YqelLq6EYSq8NHBklj2bEuh8dzelgVoXB7498hVCiIgfXJxFVwwLac52Oz7+J0aLLUGNc7IeyFPr2PonXFiAh5/6BShL307/PNhy7Pcnons9D1mJaJ6KvDq3aCYTV1zKzbYcH6Y+GpCKiw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1730159736; c=relaxed/relaxed;
	bh=bjqlL3P9HBN4voyP2L5yXiRhMBCYac+G+6cqIX9zAoQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BHSRA069Bz8QMotKrWQCFP1sc8p+LshuK6bxBsqk+lXEWmFK8GCdTlH5l+eBmhcyRk47aC0viCFNDMf/k6KikRAVcax6fhYKti+J44kis+JvNvBYUPyhgJ00CWUJ+IGKJiFUJNpP2P7QIrNgeO7RewTq93Bv37devW4h3T4xfbS7TJ8FhUHJHozA+fczZXxEjFCxWYDI8mfJi+TqOecQMTimmAp3LOcz9l4qPFkXXiSw9d2UgHkEoNNDQoU1MmXvSd3UbSTmxrkuKFlaCqQVf02iANIBRb6bbswkGekWbZ50YbgeeHyG0pCZfAClJ00ONcUP5B1GDTdfmNe4IMuFAw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=CNA8hmve; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=CNA8hmve;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XcqyZ53Xdz2xrC
	for <linux-aspeed@lists.ozlabs.org>; Tue, 29 Oct 2024 10:55:34 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1730159732;
	bh=bjqlL3P9HBN4voyP2L5yXiRhMBCYac+G+6cqIX9zAoQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=CNA8hmvef1s42GR010rD7RxBEzuLHnOSLEfuTT4ohExeXOUCtAQ3i+ii9BKdYKgKV
	 oo+ShgOBibYW+XnZbEV/vB+1TfNLRQXjyFJrz0LhuGlcgReHpnuvlFkW7MOxNEvdvd
	 ww1dmGu+0KI665WZPEqhRujOC1/thS7nO3Rjd+GF5ltVm7gahHiv7Iu4N/GsSAxdx2
	 l7lujEO43zAdpezhv6vA4WZmuVsYw2em11xjIbHBYTxBvLb6JIajA3ovfIYuJwq89Q
	 8yOFQNx3fu39RpTxjMjnWcvV1eDs6PkTYpfahkMeC4b4BbiELz9EC3tL/4My1i9pUT
	 ow3BSW4nRJKLw==
Received: from [192.168.68.112] (ppp118-210-190-243.adl-adc-lon-bras34.tpg.internode.on.net [118.210.190.243])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 91D4F67728;
	Tue, 29 Oct 2024 07:55:26 +0800 (AWST)
Message-ID: <0b51600b1308d64e362b771f1bf8adde2fa0fc19.camel@codeconstruct.com.au>
Subject: Re: [PATCH v2 1/3] ARM: dts: aspeed: Add WDT controller into alias
 field
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>, patrick@stwcx.xyz, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, joel@jms.id.au, 
	wim@linux-watchdog.org, linux@roeck-us.net, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org
Cc: Peter.Yin@quantatw.com, Patrick_NC_Lin@wiwynn.com, Bonnie_Lo@wiwynn.com,
  DELPHINE_CHIU@wiwynn.com, bmc-sw@aspeedtech.com,
 chnguyen@amperecomputing.com
Date: Tue, 29 Oct 2024 10:25:20 +1030
In-Reply-To: <20241028024813.2416962-2-chin-ting_kuo@aspeedtech.com>
References: <20241028024813.2416962-1-chin-ting_kuo@aspeedtech.com>
	 <20241028024813.2416962-2-chin-ting_kuo@aspeedtech.com>
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
MIME-Version: 1.0

On Mon, 2024-10-28 at 10:48 +0800, Chin-Ting Kuo wrote:
> Add WDT controller into alias field. After that, WDT index,
> used to distinguish different WDT controllers in the driver,
> can be gotten by using of_alias_get_id dts API.

I feel it would be less brittle if we encode the mapping in the driver?
Based on reg the driver can derive the watchdog index. That way there's
no constraint on how the platform architect arranges the aliases for
the watchdogs (if they define them at all).

Andrew

