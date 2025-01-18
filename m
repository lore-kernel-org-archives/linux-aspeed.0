Return-Path: <linux-aspeed+bounces-525-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7415BC02185
	for <linux-aspeed@archiver.kernel.org>; Sat, 18 Jan 2025 03:51:24 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YZjMG5qXRz2yn4;
	Sat, 18 Jan 2025 14:51:22 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2604:1380:45d1:ec00::3"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1737172282;
	cv=none; b=YNcKwNJOfPr22so8qtXasLMevygZuYIuDnxmjxC0Tw7u3ws1r17QJcKQ0QBQEduFdt0Cr90fRRkEenhKufWRMluxV6AHnGXWG0FzZlQLw6T3NWZiTzuM9pJTb2TgW/ArBo3jYKKK/EWLDf4PlEx3j4/IexA8b9NfoV93TWpwsGVenJkLFT9ZeCNR95rsKw78Dt7vMj267cZbff9jC5Tnefn1IuWDlKrhYZL5irGBZEH0gLPrQSd/L+8dy6Hp6d6lFTvSpOHkxQAuL7WezHdKatiaIGf6c9oLay+VKIc8G/e0UBbGJZP732w5X7O1k5UN2gi3awyhIE7ongWCv4ovxA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1737172282; c=relaxed/relaxed;
	bh=/DyfZWIIA96g0Ckt/iF1SREvxeObReWViBxkd40Wrkw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I9R/9p6Boygrrdc/NOu2yDa5cb1x7M4mKqFnF7BNGZthoYVAuAqpii5qDT25PdKvD9CIpn2kn8exd/aQoDSDjkHrmWAYnma94OZeibsqJifzjZLtIfVjb14GyfZ/aF3WlOC6xnRK9ArC6AZbmUNoHBxWEf5MYC/eVcYAEKnr1jAhOwascOrc7O0TBF8JJjiDCdAkWwHxXwiRCOTlC3M7ubVlInjhIcn4XwpppZh5yqAhl/qTRxZE3pV773JQjmRZ6JVL09mqFqVF0qz/Pg7+IZ4u9eM6ZZMc2UnS+IbrtYnN4I0EFQ3Gdx5BDVH426jY8KKTi3G+APVgzLHLiiqt0A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Wg4O7nHq; dkim-atps=neutral; spf=pass (client-ip=2604:1380:45d1:ec00::3; helo=nyc.source.kernel.org; envelope-from=kuba@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Wg4O7nHq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:45d1:ec00::3; helo=nyc.source.kernel.org; envelope-from=kuba@kernel.org; receiver=lists.ozlabs.org)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [IPv6:2604:1380:45d1:ec00::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YZjMG09NSz2ymg
	for <linux-aspeed@lists.ozlabs.org>; Sat, 18 Jan 2025 14:51:21 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id B43DBA43169;
	Sat, 18 Jan 2025 03:49:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A859CC4CED1;
	Sat, 18 Jan 2025 03:51:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737172278;
	bh=/DyfZWIIA96g0Ckt/iF1SREvxeObReWViBxkd40Wrkw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Wg4O7nHqeAoZVFYyETYyeYu6pLx6d3Q1QDps4UyzGqUKor6alhi/0n71XGBldQ4HW
	 TZHLh9qrSEZu5RiK1HiCETkuZ1otS4LxtUJY6RwUDnfymgyNy3ZbrOKVDeEBj9q7CU
	 UXN0fhkBZw7KqeXXZPBMGEXi55Z/M9coD9wv2rMoS8l9qMX42xjPco8QGcWlCVpt7r
	 gBzDWBu+xgQnyce5DuwaRJ4ubCN1fvudUEEqWXVRWjVTxqmFncxVG0lakKlY4uLFez
	 v2s8ETIJ+tuqmEYDoo6wEkJkG31MGrlc4fLDXUJLpJQYAa6foQhUuxHZJMAuI2mox+
	 CQFRLjx1V97pg==
Date: Fri, 17 Jan 2025 19:51:16 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: andrew+netdev@lunn.ch
Cc: Ninad Palsule <ninad@linux.ibm.com>, minyard@acm.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com,
 openipmi-developer@lists.sourceforge.net, netdev@vger.kernel.org,
 joel@jms.id.au, andrew@codeconstruct.com.au, devicetree@vger.kernel.org,
 eajames@linux.ibm.com, linux-arm-kernel@lists.infradead.org,
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 01/10] dt-bindings: net: faraday,ftgmac100: Add phys
 mode
Message-ID: <20250117195116.4211ef42@kernel.org>
In-Reply-To: <20250116203527.2102742-2-ninad@linux.ibm.com>
References: <20250116203527.2102742-1-ninad@linux.ibm.com>
	<20250116203527.2102742-2-ninad@linux.ibm.com>
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
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 16 Jan 2025 14:35:16 -0600 Ninad Palsule wrote:
> Aspeed device supports rgmii, rgmii-id, rgmii-rxid, rgmii-txid so
> document them.

Andrew, just to be sure - you're okay with extending the bindings?

