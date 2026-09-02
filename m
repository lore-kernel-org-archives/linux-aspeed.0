Return-Path: <linux-aspeed+bounces-4921-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55B63C624D4
	for <linux-aspeed@archiver.kernel.org>; Wed,  2 Sep 2026 16:16:11 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hZnsP3gPBz2xlY;
	Thu, 03 Sep 2026 02:16:09 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a01:4f9:3051:3f93::2"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788365769;
	cv=none; b=lODUEKlOTc+UYvt6oCXUP0yZK6h9wJ+4IiVIbsQijLZ95lFRsCEsFEAmFWUV34AFneqdwPfJ+qMg0VB5sMowetER9sSrL9dvgMZXf8rus7OTfgDw4frvimyHLrdqE52HCc1XOyzXNH8NVzf9wnNp1UmOwRUOafFKlFZ2/57iO7mEqcn9dGYuHEAnKayGLq/0EsD1QGJH7nsgiHavGCtxTy5FRZu/Jd6drs/5eRwWDa3gHmNXCosqqSy+7CTztmzELLDA5hwjehdYpAhB+Uok432PBYBCpqCKDMidiYwki4d/YYNoRHudgo3PTwHviN501SHI2T6E02Xkid7b0teX/w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788365769; c=relaxed/relaxed;
	bh=8EBwRXRgxnDgc1hzoXKaNCqP19NjmMioRMdJEYoHAwY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JABmzqOxG8hEkrMBbsGd2nJMzHdly9FL5o/iwGwUwP9u0xy4NJ8JQlYWgpOczzHeFiZhYWW4vKS5PVP+5Q/0rGZ1OnjJCIQfMmmVlAsNNiDjjSvRSdOxtc2+3AT3v8Ev8OV3N8q94fFynflv4bdxvxehljRQ1Ywyy9hGygEQuwxDq+GKeH4BdWXP/JqpyMOIxH4bWyIJa/xdR8MYmF4fj1wHYlTqndb1ecanbkXhjz9qmVjuV08+eg6ZtDYooWVJ1QGL/NvDKQ64pvAChurQ5/pBexJO04W6CqCtlNDBG04UuGm8Jq5w4605v25hyDTiJiWNEkWrmPQXUGVOpdRXxw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=alien8.de; dkim=pass (4096-bit key; unprotected) header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256 header.s=alien8 header.b=adij380J; dkim-atps=neutral; spf=pass (client-ip=2a01:4f9:3051:3f93::2; helo=mail.alien8.de; envelope-from=bp@alien8.de; receiver=lists.ozlabs.org) smtp.mailfrom=alien8.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (4096-bit key; unprotected) header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256 header.s=alien8 header.b=adij380J;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=alien8.de (client-ip=2a01:4f9:3051:3f93::2; helo=mail.alien8.de; envelope-from=bp@alien8.de; receiver=lists.ozlabs.org)
X-Greylist: delayed 398 seconds by postgrey-1.37 at boromir; Thu, 03 Sep 2026 02:16:06 AEST
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hZnsL4mG2z2xLd
	for <linux-aspeed@lists.ozlabs.org>; Thu, 03 Sep 2026 02:16:06 +1000 (AEST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 4D69A40E039E;
	Wed,  2 Sep 2026 16:09:15 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id EMw9dlDvPqEm; Wed,  2 Sep 2026 16:09:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1788365343; bh=8EBwRXRgxnDgc1hzoXKaNCqP19NjmMioRMdJEYoHAwY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=adij380JJaT1VPcepZIup1x17uVcz+DEuwbfV4MGy5ccR5YSHhn8LKMEo2oVcw50b
	 K6avUY+ttC70+rhwRgYFOSBiaW0DZhCoQKvHzHp+0zQ87+gzMuXyA71yuDS9XZvswn
	 WjRkl33Q6GS7NG/EOeIGWR/rFL1gcsHoHxNhOkdT8oMLighw9/QIkG8eqKkZTerSVv
	 trSfgLi0cld1yJYAUOCFzmLwboFG2Ktcrbg7W0aTZCtRsHMHbpAwHpYnG6DO2PQKt8
	 9O1Xc9ZZLUxrGGVOGKR6MbsAhWs4zollXkOFrSOAlqiPrLfqFRo2UqfZtM1AVO067Q
	 58rObV9SQ1TQ+nQtGP1Otz/m7MJep4FAN30TyIZZ4FdQlOVpc4jCdi7kq8RIOCiV+G
	 FTx1NKT720mBUIDSoEJQvquGLNfNM7skAnJisqS9LD1sUQO09dkml87ZCi+qf3fJGH
	 2O4n070uB6E4/1Kp2yIeMcU/QMIjh/M3ORK3PQJ8iz/E5CrR8FNq9wkwrfEfQKH3NB
	 gSd2TB63/zLm3HycNcbo+uf2sBPxY/e+hnTMmdRfc1kvPZCR4Qnwu4lLBTRML4KyX/
	 155CLDCOAaxzAPIVpiXl3EABqJRUSOTUcrHN7yF/XxDX6nVfdMkUEfiDgThs9z9rd5
	 a0NoRBfgayOU7NkWATWC595Y=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4E36C40E024B;
	Wed,  2 Sep 2026 16:08:47 +0000 (UTC)
Date: Wed, 2 Sep 2026 09:08:43 -0700
From: Borislav Petkov <bp@alien8.de>
To: Ryan Chen <ryan_chen@aspeedtech.com>
Cc: Stefan Schaeckeler <sschaeck@cisco.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Tony Luck <tony.luck@intel.com>, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 0/8] Add Aspeed AST2700 SDRAM EDAC support
Message-ID: <20260902160843.GCaphKC-y8HpkiAIWh@fat_crate.local>
References: <20260824-edac-v2-0-c8d8bb693586@aspeedtech.com>
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
In-Reply-To: <20260824-edac-v2-0-c8d8bb693586@aspeedtech.com>

On Mon, Aug 24, 2026 at 10:42:27AM +0800, Ryan Chen wrote:
> Add ECC error reporting for the Aspeed AST2700 SoC to the existing
> aspeed_edac driver.
> 
> The AST2700 memory controller keeps the same overall EDAC programming
> model as the earlier Aspeed BMC SoCs, but uses a different register
> layout, a split interrupt status/clear/mask scheme and DDR4/DDR5 memory.
> Rather than fork the driver, the existing code is first tidied and
> generalised, then the AST2700 is added as one more per-SoC variant.
> 
> Patches 2-5 are bug fixes and cleanups to the existing driver. Patches 6
> and 7 rework the implementation to accommodate the AST2700. Patch 8 adds
> the AST2700 support itself.

Sashiko has comments:

https://sashiko.dev/#/patchset/20260824-edac-v2-0-c8d8bb693586%40aspeedtech.com

Please address them: if valid, fix them, if not, explain why they don't need
to be fixed.

Btw, I don't see Stefan reviewing this driver and his last mail on LKML is
from 2025 so it looks like we'll orphan this driver too.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

