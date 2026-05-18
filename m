Return-Path: <linux-aspeed+bounces-4050-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A9E5CD4F3C
	for <linux-aspeed@archiver.kernel.org>; Mon, 18 May 2026 06:43:34 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gJpD54XPzz3brc;
	Mon, 18 May 2026 16:43:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779086613;
	cv=none; b=MgAfeSbbQl4IaGKIqlc4+70zPIvnua9rZRCE5UEgZndMBEQYYD2SiHflDLN+xYA1SiMKPOfrEw0iL7BudhpN2FtpWw3midWhv9gXoa7unrFmf9yAak8F1yABDmL0+Y3PFhCrSGXTJEarjKVwd9I4lZqSwH9kV2Vc4os4DG1BxVwOcI17f9R0LKA26I/qtINAN8UfYtIzfZ4abLX2zrA1Ju87uMYrYcoG4c+fZvC0K19EgLHxIYYFmoCB153WUyOVcDGdDOtLr9X7L3DRzEQadxHrjz4hymwlMBMmbKzMR841b/O4xDX+ITrCCmjrttxdveOR6GRJ9Zv8Xp/5wjEdUg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779086613; c=relaxed/relaxed;
	bh=fpwXJPMyON2eWtQYaGV+3QNAbVJ3mx8rU5QiQ/o+uTc=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=BVADYNe75Rc9oo/JXg2f5ipGipCq+dTRZ3+1fX/35Lpe8M9wpURc775YXPUb2Rm4aLZ1IddcUlZZdP5v8PcxYZH6MrW08cL6kpFxfrDEUf1OH6mFZ89w9ygJgB8fG5HnNyTK7Bqx6BIMqv8OqyUMLmQ7fM0IhbljZh1d3IYaygw3SBtwxn3uDBjJ1tD7RQmPWxY/j0dBO4RSz3GCRu6jDAzfv/J4E4LCz27CIb+Aho/5N+FRIVJgGJ9P4aKaNvxvt3+PsPqzHwP5pD5szRP4h9cJjpqegVODAnNk+/HsP+yFUoR+q9uBR8tWFEQc7q/gPBovq6UFpNP0loVxZr8chA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=S4G57Ejk; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=S4G57Ejk;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gJpD46yNsz2yQH
	for <linux-aspeed@lists.ozlabs.org>; Mon, 18 May 2026 16:43:32 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1779086612;
	bh=fpwXJPMyON2eWtQYaGV+3QNAbVJ3mx8rU5QiQ/o+uTc=;
	h=From:To:In-Reply-To:References:Subject:Date;
	b=S4G57EjkcItjKyOzc3wgqcYj/W7Jo7P+GnbppqCtdkLgNfDi1vkxrbwp1Bb8Vab1W
	 SkXGY8ZpyeKHuKnxhe28E4OvWuRt/db/18611N0GszPw3yvhwKKCSfRfBOUnbFsQV2
	 O9ItcIMHLzcaaL4DQnwGUJlIDi1Wl/BEvLnXuq2j4/aFsitYa0GDObxG1NzaItARcP
	 XfwOM9fFLZqW+yHYAr7E8AGtqVHiEwdeT7YisxZdup1hxfbn1QLt4JGrwKz4aoIL5t
	 S08G5m++8iqp8mTALV4VIyxX99nLuZ0wucRteEnMmfTTDF3jdgvyFIcQ6l+jKfgnb8
	 ex90ei2OG2wqw==
Received: from [127.0.1.1] (unknown [180.150.112.11])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id EF63F6025D;
	Mon, 18 May 2026 14:43:31 +0800 (AWST)
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Joel Stanley <joel@jms.id.au>, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
In-Reply-To: <20260505102635.160772-2-krzysztof.kozlowski@oss.qualcomm.com>
References: <20260505102635.160772-2-krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: [PATCH] soc: aspeed: Move MODULE_DEVICE_TABLE next to the
 table itself
Message-Id: <177908661185.1619049.12663504861396932958.b4-ty@b4>
Date: Mon, 18 May 2026 16:13:31 +0930
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
X-Mailer: b4 0.15.2

On Tue, 05 May 2026 12:26:36 +0200, Krzysztof Kozlowski wrote:
> By convention MODULE_DEVICE_TABLE() immediately follows the ID table it
> exports, because this is easier to read and verify.  It also makes more
> sense since #ifdef for ACPI or OF could hide both of them.
> 
> Most of the privers already have this correctly placed, so adjust
> the missing ones.  No functional impact.
> 
> [...]

Thanks, I've applied this to the BMC tree.

-- 
Andrew Jeffery <andrew@codeconstruct.com.au>


