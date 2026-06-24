Return-Path: <linux-aspeed+bounces-4301-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E46E8CDB479
	for <linux-aspeed@archiver.kernel.org>; Wed, 24 Jun 2026 21:21:59 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4glvyZ2Ch7z2xSN;
	Thu, 25 Jun 2026 07:21:58 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782336118;
	cv=none; b=BXH7pNLUa3dJbsDxrw0piAqKr07DvBAfDqISFurgDJdLZju3O3ECszsbQ/TXIGVJpYckdQ6B9Qhd5FNTAt5k9A7PXRx/rRVcMNp6lwfFaKhnImyMi6WMJimNHT+bXo+T0wfet6IpyU2RfWG2uqGDErXiYEKncrV2KDWys3XVL5Ftdol4FnkIMeQikYgJnrR80SCJQmnmoemODW30m2C621XrTiXGO8TzTbNelU0aO+FvGo8Z2HOhwY0cokb/vKvnqV6lH+rxRa24dETx6Kcjp/i29RN02gTFzWx0Ul453QlpQL4jp1WLvosG3tnU/eS1+UTvmgyrGQFM1O3+KeZu8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782336118; c=relaxed/relaxed;
	bh=BxRZgMMcXld1GewrTn/+Bpz0RNC0eo+0XsbHRMtaIMw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ngxBb0q8LLenG5zTdGfLlNCA5QLsdVtDs0Lev7/g9jp1Uqst6N64s9BnehItjxWKG+zOY8EzAxQWJ7vUymQYoGpPo7J+oQFoHGw9uavd9QKa4cPKRXAw4w/HiapPfHBv0ODo8+TX9J1alnNI+OvnkXbsOLETwBA4IvL3A5XYKN5T2cSmOZRtLn0Cy3hRxC7Fo6yPj3PENCpt4NEsW3xNyHc2qYHDibVr41XE215V1njKsJ6K+i6/Iu+1Yvif1geV91AVdjIbcbnZ+aB8APr1MNbH//+7t/vujVq/Nz1WCUsQ13GkZpa3DRt5S1BfGR9yCCoJqf66UJTl5+kwsQnu+Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=XTaTgVlK; dkim-atps=neutral; spf=pass (client-ip=185.171.202.116; helo=smtpout-04.galae.net; envelope-from=alexandre.belloni@bootlin.com; receiver=lists.ozlabs.org) smtp.mailfrom=bootlin.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=XTaTgVlK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bootlin.com (client-ip=185.171.202.116; helo=smtpout-04.galae.net; envelope-from=alexandre.belloni@bootlin.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 314 seconds by postgrey-1.37 at boromir; Thu, 25 Jun 2026 07:21:56 AEST
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4glvyX6XZtz2xLk
	for <linux-aspeed@lists.ozlabs.org>; Thu, 25 Jun 2026 07:21:55 +1000 (AEST)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id A40D9C6B3B9;
	Wed, 24 Jun 2026 21:16:44 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 884E9601C5;
	Wed, 24 Jun 2026 21:16:36 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 79617106C8468;
	Wed, 24 Jun 2026 23:16:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1782335795; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=BxRZgMMcXld1GewrTn/+Bpz0RNC0eo+0XsbHRMtaIMw=;
	b=XTaTgVlKy08X8NDZtKOCQMu0BDALNDA0VYnboGRbodz5KICDzsoe4bn0H5ghMcfYsNHzf7
	QMT8V300UIJts32vRAKK3n2sFo2SrX3dkNMMy4kNW3ZcWTiYwg455hdjrmmZSwa7RdIiR7
	Etdi+5yxsda+qPlla29otIKBa2fFVLaxtJTit1ZpM7ILtmyrvF1ka/ptJCXh10z/j2Ee06
	yXaN2S8hPf4dtbjbq7roFJHxyv/6TVa2zH4at9ce7yyJKx1KCjDwRzQXuSOiYOqfYxVf2B
	gnr2CF7QMCoYoKGVEZR4R7tZQv4JfCKAtcoichw7aUXYzB2Nyqz2/jyQM2deDw==
Date: Wed, 24 Jun 2026 23:16:31 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Tommy Huang <tommy_huang@aspeedtech.com>
Cc: linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org
Subject: Re: [PATCH 0/2] rtc: aspeed: Add AST2700 RTC support
Message-ID: <178233558822.1517260.6981271146090179790.b4-ty@b4>
References: <20260601-ast2700-rtc-v1-0-15d4ca46500a@aspeedtech.com>
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
In-Reply-To: <20260601-ast2700-rtc-v1-0-15d4ca46500a@aspeedtech.com>
X-Last-TLS-Session-Version: TLSv1.3

On Mon, 01 Jun 2026 17:14:05 +0800, Tommy Huang wrote:
> This patch series adds support for the ASPEED AST2700 RTC define,
> includeing dt-binding in the Document and rtc-aspeed.c

Applied, thanks!

[1/2] dt-bindings: rtc: add ASPEED AST2700 compatible
      https://git.kernel.org/abelloni/c/5e7f746bc106
[2/2] rtc: aspeed: add AST2700 compatible
      https://git.kernel.org/abelloni/c/3319cfeeb8c4

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

