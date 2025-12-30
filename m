Return-Path: <linux-aspeed+bounces-3233-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91600E92FD2
	for <linux-aspeed@archiver.kernel.org>; Tue, 30 Dec 2025 02:22:48 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dgH1L4VCKz2yDk;
	Tue, 30 Dec 2025 13:22:46 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1767061366;
	cv=none; b=goh+/uMWt5sf5YXfX57AzuadBt2gQ8JuZliycZSY3Hfa8jrbnsiSHpolATKP7B10fQnKmxs/rjCIBXpydpn/x+/t8ygOKC0ChzsNDnO3hwdGGGBz2CZfI7B8BJOGqg0KbSEp5PqTLyqAEeA9OQEj8MAVtm9+CTJmxOdQkjjByrvF8zueJaRT/ctH593lZdK092W+jXUr3A4uyV8I0tfaq2y5XRz99JlX5MHyVnqCQY/mAaeLDJGKaGW0SbaPweRX/g+ymagGlvUyuFAYLv3/7DZ95uwJxyaqChBwWGuE94ZgQXG36fDv7asKQRB/qw28H2lIiPBU3HSlkQTkwxm9xA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1767061366; c=relaxed/relaxed;
	bh=W7MuhpFuhJOuB1ZkxXNKbETWpshIvQ50dTBnFcWSOFE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dY90DKcgvb805AwoKImyBaAyvZ1Ibo8slsnIa5XIiJlHxnNT0ypBNCldcONmQOXDEUtieL3W5ceBCH1bmCI/Ml3ZE7X8aZsRGochWDi91xFlfhuQK9USaJGYsa0Y4eGl0UZVk7TpVUDcJ74KQCFeKcssqozf0kh/ziXZB051ELMuDU+eyLb/hdkGU7KnC8PbP7sqjIWol0kFdbCrmuYKE4hdC4gzSQQD9zYKOmeo/jMWNb8BLJPV/OtOoDbM/+EIcqvjaSmvYb5vyoFGCjMZ2jRgLth6pCTLjTgDygCWGFBjeUPsY3e7t7Q6IEa7nemJMZ+7HTeq2lHNkfhEPe/h8w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=EAkkOMjt; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=EAkkOMjt;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dgH1K3s8pz2yD4
	for <linux-aspeed@lists.ozlabs.org>; Tue, 30 Dec 2025 13:22:45 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 55E12403F0;
	Tue, 30 Dec 2025 02:22:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00C03C4CEF7;
	Tue, 30 Dec 2025 02:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767061362;
	bh=/psuR/3hwPcJXh/QxQDIWHYcRBOf2JQDF0tA2oZ5EE4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EAkkOMjtE/NFwqwLKKAWdE4xg1Nr453fHrv9QVVH43Hg5+P3MubD75i3BHxBcSSZX
	 foTwDCvNTSAAB9tLotyetesFJWYUIhfxy44jZxEV3EFR7cbCr9GBluN7WzUpWTSuKa
	 CIrAiqGq6c4JPcTFQOssiyfDelYfsv/O7b8EsSxJwZP5csbmWGb05DDkOFBW118XlQ
	 gPvfZfHAG7DhoGBBuoD4+XsWrZJt3F0iEP4Tmf4I3pVDMo6M6RXAW+Mo+CNKidWHh+
	 iAwD9Qfsqp8L6OcJsTbop8CxB3j4XTgrBjP9N96E4JsZRuR2LakMa4SjYdJtc8tzWO
	 sP13ghCLyxpmQ==
Date: Mon, 29 Dec 2025 20:22:41 -0600
From: Rob Herring <robh@kernel.org>
To: Akiyoshi Kurita <weibu@redadmin.org>
Cc: Guenter Roeck <linux@roeck-us.net>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: dt-bindings: hwmon: aspeed-pwm-tacho: fix typos
Message-ID: <20251230022241.GA3214066-robh@kernel.org>
References: <20251224083845.2727976-1-weibu@redadmin.org>
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
In-Reply-To: <20251224083845.2727976-1-weibu@redadmin.org>

On Wed, Dec 24, 2025 at 05:38:45PM +0900, Akiyoshi Kurita wrote:
> Fix "upto" -> "up to" occurrences and add missing "be" in one sentence.

This is in the process of being converted to schema. Please review that 
patch and check these issues are not copied over.

In general, don't fix .txt bindings. Convert to schema if you want to 
improve them.

Rob


