Return-Path: <linux-aspeed+bounces-84-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CE91D40D08
	for <linux-aspeed@archiver.kernel.org>; Wed,  6 Nov 2024 00:37:44 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XjmWW4HtNz2yRG;
	Wed,  6 Nov 2024 11:37:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1730853463;
	cv=none; b=XUu5BpeCZUBw3YQFdV2342WvhtO2Mf/YE4Pp9LISgLB95IxtVqu0ZL5nTp06zCwctDlIGgOZ/abQA7lhEspwpxyzbwYciLy8+5a4P9xZI/ePD9x6268TmYydOFdxrgwhZaEqQvP7Wp+wsi/g9w4CxDew5gitCb/NCyF1S54T0NxhAg7yLzQnhRwJMZ9KZsYOahlIjOXcJDN78HV5yqw8cy9FNKlY/uubjGBXnoI6shRADanqmhz5nyGdB+oR6SxHreZ7e7aEdFkD4OOh4MvLz/ux+KuaMDcWVHd6ErG6ySso79OVsemL1JzyUJfx4Gqq1k0hI3hy0VqprJ1KqyeNNg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1730853463; c=relaxed/relaxed;
	bh=MEcFU5Iqsgm3U1kleL1AuXyG0d6sZHwbrluDEXSnsOE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=BAXRHOIdbbpT1FAYul/Tf9QPJ3ljWdYEkp4ASI8qqqh4A8pO1Wb6R8VX/lt7J/puXbdBtvYapXfSJ1wm0gqssk9kTi/EiBPb7NXn+c/8WxqxLxyKOMxacSQCp3igdqnh9t5nhbtuDxk9TSSMy3nTKPqJ20O3omCBnXfQG08qhNND+woHqk2ljkx9NvJObVZ/7xBcalTqXBqN9kCXJh3e3AtSWglhiKNQWBoU5kk0dGXNAZUPJwA3jbIbUwXMnrUcyOqhrFnWBiVZbtIkIWVD0A0YUj2+3Uoqr8in4DTprLLWH1lgvOM6SzGWeKEPX+6dBCsW9v+BGt6eto4hdj+VDA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=d2fqNuW7; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=d2fqNuW7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XjmWT5sG0z2yLV
	for <linux-aspeed@lists.ozlabs.org>; Wed,  6 Nov 2024 11:37:41 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1730853459;
	bh=MEcFU5Iqsgm3U1kleL1AuXyG0d6sZHwbrluDEXSnsOE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=d2fqNuW7b4RXmB3s7G5PSJmu0Z6xCG88TD6MYvWYhkjYPejnPRZYYXKLr9d4Gw9rD
	 P2yyInckCQLVw8ri12qNsZKAKnwTz07MOkRhuVsrmEJztJTZ81n+cAkDXagwI7Qnc+
	 TV8HacgBK9b1iyD656HuSIs00K6kuz3Xfjd6TZeDSGcvcR7w3EGozUkAS7cb9cSvr8
	 YmeyNv0cGwo/NOmbeS2UZalwT9pJNcD8v0KmjIako8kMbDlIV8ahDRxPuPBgijJbDl
	 Xp1w0W9Mj9uKu4fwWQ6ibR/pj9iaO/xUBNmyo/cYrkIM8NfrmicA+49mQJxn8FVHk9
	 koqwVmoXXpIzA==
Received: from [127.0.1.1] (ppp118-210-162-114.adl-adc-lon-bras34.tpg.internode.on.net [118.210.162.114])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id CF8176B28B;
	Wed,  6 Nov 2024 08:37:35 +0800 (AWST)
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, jdelvare@suse.com, 
 linux@roeck-us.net, sylv@sylv.io, linux-hwmon@vger.kernel.org, 
 Joel Stanley <joel@jms.id.au>, 
 Naresh Solanki <naresh.solanki@9elements.com>
Cc: Conor Dooley <conor.dooley@microchip.com>, 
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org
In-Reply-To: <20241104092220.2268805-1-naresh.solanki@9elements.com>
References: <20241104092220.2268805-1-naresh.solanki@9elements.com>
Subject: Re: [PATCH v6 1/2] dt-bindings: arm: aspeed: add IBM SBP1 board
Message-Id: <173085345571.351006.17162436911260710903.b4-ty@codeconstruct.com.au>
Date: Wed, 06 Nov 2024 11:07:35 +1030
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.1

On Mon, 04 Nov 2024 14:52:14 +0530, Naresh Solanki wrote:
> Document the new compatibles used on IBM SBP1.
> 
> 

Thanks, I've applied this to be picked up through the BMC tree.

--
Andrew Jeffery <andrew@codeconstruct.com.au>


