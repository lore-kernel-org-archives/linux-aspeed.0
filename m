Return-Path: <linux-aspeed+bounces-3739-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C27BDEC01A0
	for <linux-aspeed@archiver.kernel.org>; Mon, 23 Mar 2026 07:46:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ffQGx1fT2z2yZN;
	Mon, 23 Mar 2026 18:46:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774252009;
	cv=none; b=Qho8TXNfI7RpWoWVRKW2oQ7Q0FvbGjWLVAWw7OLyBzuJ28z4t+YU4SoHXCb1XpIq8y6JtfeNuNOdrMt+uPcAtMqIm4V4nxjy+f13nzI9cx8455toPfhTwo2wFtJumtoymNA2a3FsORtFhaEvsVBuT1vrNrieiHHQdwho0zHAhFdeDC+ke4nWtQZc8yPZSZWVFixbxOwb7rewTpFNhPu9tICwZm6kMU1QtqvLXH3tBRgsVLTojUkdihH3MVb519KKue6nP+Czn/Rtt31elrd+E2I2cYz73rRYCxHCpnAakdpuynOkPMH2qHqnhPXJEohQdMyrQ/y7uLJT58IUN+iqTg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774252009; c=relaxed/relaxed;
	bh=a3cJ44yM+NmRrca7V3uKaOczEtsL7ikYY/fGrJvDBzQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bm1U0iYJGoU90yDir6l1JjhJvu5kG3KrfaCxiYSQ9JPaANX39ftYcfJt+8gFQeDVpdhq40bAxHe1cEBVxUZfDoGkKBWIhbksiM1PnZxPpc5Guv7Hhe5mLPeKecUBQw+FnWGPJoHmveZ34ckh0Najo4Lz0NsIppoX0bS2rNQ56PsZpS1ST8FpZegJy6XzGdqkohFX45tNFb+CNKrpOILncZ72y80/J6v5l3rraWSPdgXO82Zio+D6PUwd1INwYV+tcImf8OmkUlrgrkQw+cnGBEfomrSd0s7ZhPfwSSWBY2cnQP/8ez8VWZBtcncGA/jybEBiumYDmPLwlBE5vE41ug==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=DKBIV45S; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=DKBIV45S;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ffQGw2HFlz2yYy;
	Mon, 23 Mar 2026 18:46:48 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 995A7600CB;
	Mon, 23 Mar 2026 07:46:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0E54C4CEF7;
	Mon, 23 Mar 2026 07:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774252005;
	bh=Wio9gMPqHdSGHZEDnEngY8SYE39grryI9XLE6l3oDWE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DKBIV45SW7jYRmcJVtvHXKV3XffQQLnB0h0o4rBJ+x8MFpB7spa4sWYcUb9zxJtSR
	 Em44JRqOzEDzoaRis98/wG516c2uGmuUGklH9kmt1y1IzaLaijhkCMRZR2veXVcUH8
	 7h+YLi9Kq/iP4P8oYnFMQvWhEvy1e43lDIUJykhe4ZntsdfJkWZ3SmOMhIFan24bwB
	 gukcErCqbnAR2V2EpMabOvh9Ad7fw59C3pwWL1FmmrXRh9ODcfG/HpGb3wZHbqq2rp
	 lkEvMpfz7OZVB2Cno8KiSZNO83VNnlyJBs8OfPwRDrfysDNJIk0HcRDRB0rlIkbzdW
	 I55lgMa+UJkRQ==
Date: Mon, 23 Mar 2026 08:46:42 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Ryan Chen <ryan_chen@aspeedtech.com>
Cc: Andrew Jeffery <andrew@codeconstruct.com.au>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Joel Stanley <joel@jms.id.au>, Ryan Chen <ryanchen.aspeed@gmail.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Andrew Jeffery <andrew@aj.id.au>, linux-aspeed@lists.ozlabs.org, openbmc@lists.ozlabs.org, 
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] mmc: sdhci-of-aspeed: Handle optional controller
 reset
Message-ID: <20260323-glossy-industrious-dog-63b1e6@quoll>
References: <20260323-sdhci-v3-0-93555b8f6411@aspeedtech.com>
 <20260323-sdhci-v3-2-93555b8f6411@aspeedtech.com>
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
In-Reply-To: <20260323-sdhci-v3-2-93555b8f6411@aspeedtech.com>

On Mon, Mar 23, 2026 at 10:07:08AM +0800, Ryan Chen wrote:
> Get the optional reset line for the ASPEED SD controller during probe by
> using devm_reset_control_get_optional_exclusive_deasserted().
> 
> This allows platforms such as AST2700, which require the SD controller
> to be taken out of reset before use, to work with the existing driver.
> 
> Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
> ---
> Changes in v2:
> - use devm_reset_control_get_optional_exclusive_deasserted replace
>   reset_control_get_optional_exclusive.
> - add include reset.h

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof


