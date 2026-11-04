Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBDC6606A333
	for <linux-aspeed@archiver.kernel.org>; Wed,  4 Nov 2026 14:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hEYLohFI
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jKT0F0cJ2z2xb9;
	Thu, 05 Nov 2026 01:51:09 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793803868;
	cv=none; b=lD3VG9D0oiL+p1eWxCDUCpmfCyuTC/GAq/TNJaD+NhY+kcUr1nJhG2aVbdCfjKStf2vPnnjB37E7ajc/FwqmAIDyF7kVxlEw8/sfZaSOo026hjJaJQJ+gpg4m7KnjVgE625uiOlA0cI2ZJvINr6fUjqtCkb5oTYg2pI6Cj6w7JIbFyiZrKiRTzMbMlFNQX5iOgO8bCFOTwXTTDJ/jQt8O+vX3d2w1MP+1DjLGrHMfWA1LK7+u3krfdkHZeE2k0hmLmeFfv4I5EANohLWAHIcWZ5iZH4l2TGI2VkqdNfVwfyXukZHdDKq5fqFRhwKlOnUnRsmIOJpvZdxtyDkhgVGXg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793803868; c=relaxed/relaxed;
	bh=KZ+cSODzQCgfcBpl6SVJcEIqMlZuev5QB51iLkiBvrk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D6gIrZWF/+OEEwhYu8Yc9iNZJZiNDvpr2CVisEjCf94tK1Y5sHT+kE7yjTX3to5fYJ0gQHMQ0gvSilEGiywmVnJJtDGh09sy+7iFD0uDV+WsarIApuVnWtcQtFoKCGZgtRWHH6OtYNnULGXq4cNOOJic+YhA8jZKBQfJvSyLZrgAd9wvHPpFkavUnDsmh4TMuNeYFMOTHrvxU8aQNv7tP7KLKsBcysPE53PW4CKs451MNIY41Xt1mz2To7ihIAAXAUDFIanJv7I3ieSha2loa4n6gfzu2whCMd9dgl9hDYI5lOcBxr/XmL1EWxElo3NJZPk/KNxW5kfUuCvOqQr7Lw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hEYLohFI; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hEYLohFI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jKT0C6WRjz2xSF
	for <linux-aspeed@lists.ozlabs.org>; Thu, 05 Nov 2026 01:51:07 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 9C64443A58;
	Wed,  4 Nov 2026 14:51:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99F001F00A02;
	Wed,  4 Nov 2026 14:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793803864;
	bh=KZ+cSODzQCgfcBpl6SVJcEIqMlZuev5QB51iLkiBvrk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hEYLohFIYjvoBdLuSxCMYOa4+tBioMrRKoOn0Zd/jT9g4EOO9QpvN3p/3FXAzgWW7
	 esXIGQ1oM+hi2SxM1uYJjXqyN2OPSeovFr/0lU4pVqFY/8ztfaE3jYExzg7uSe9hgO
	 MLQhcygksG9R/0WGsdFcJNb1PMPwjMOgyqY6kai8bdC4in3FmxrdWAQpy9U7a6N+zt
	 5PWPnK4J9IzvBj7cL2QpmWMT7SapiHZcNgIhCVc5+62SYGL8qtgdkgqsr3Ni/+ioxM
	 PC+7Ze1AJyXio77uxs2uHyEKkn+IsTCkupZxreazy+ClKBmUnFbt2+FIwd5SedbkL0
	 kTyrTfW2za8lA==
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: (subset) [PATCH] ARM: dts: aspeed: Correct white-space style
Date: Wed,  4 Nov 2026 15:50:44 +0100
Message-ID: <179380380617.180018.5035897143826922583.b4-ty@b4>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260801210437.384040-2-krzysztof.kozlowski@oss.qualcomm.com>
References: <20260801210437.384040-2-krzysztof.kozlowski@oss.qualcomm.com>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=569; i=krzk@kernel.org; h=from:subject:message-id; bh=Okt3ZSzwnfGvkN/VPRaSt/4uaDxDFjo067Mc70YUqJM=; b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBq60ZFEdlmY28ps779HHOvpcaFb5uiI9gKS045I q3cX4xYIXSJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCautGRQAKCRDBN2bmhouD 1ypDD/9LsvgMsAEVjEmkOYZG43IflZC8TaSgHFnrB9O0MF4d2lGoamHBT6Bm8H1ACULZAiDjYks cKhZ4tqAa2P11cQH8yKv0P9QaaPAgAOUqag6s5vOPWp0HcGwCMM8wDJApnzmU2sZt/R4un6Ci/4 4OAoFgnvBgTuR3rkJRYScsD4u408LCTYlPVgCU8PZPLtmj3Q0DaXViKgACYykdG5AcuWGChkRbC XzRmn/sJaypEefZgzW+fTOt2zBN3vd/KcN86z6NSg/p6/DI/PL6+Ca34ZF8eyZZndpLmfMeHyNt sd9lWIRhWp5qj/L5yWM7KsDzoHS4FT5wHK2xBAeTtjne3xv6L2+Yt+CRm6w1cP0f9zqAH0uFWqH ul0DSI35KfxCQRSHERIer1YkvmR1Xhs/RPL5Mz5zxjgq9quXmOvfnq5KTft5kS/U+3JCwTOvTHy bQ3DwEcXTuKhDqSnk2ycZbE8wDSAQxu2Sr9tCmp83NWlVhWrZ7P5lbCtPkngEmfVGgn9vqqgYpE ZX8P/VOgAzGVztGOykoGjyDr2jUn7D9k3j++u2KnA+BJYQsrD5qZYxqXhoPiMkwPqHKdxdQax7D EE/N4YHwQPlDoBxPJIfcWnTHI53FhFWKJMzUUTU+uRyN0euIIN8yQLyNUoZhGAeRE2cC/NSZCVK jbohlvttijpc0q
 Q==
X-Developer-Key: i=krzk@kernel.org; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On Sat, 01 Aug 2026 23:04:38 +0200, Krzysztof Kozlowski wrote:
> Correct a few white-space issues, like missing space before bracket '{'
> character or spurious space, which will be flagged by dt-check-style
> ("redundant-whitespace" warning).  No functional changes.

This is waiting for three months without feedback, so just picked it up.

Applied, thanks!

[1/1] ARM: dts: aspeed: Correct white-space style
      https://git.kernel.org/krzk/linux-dt/c/48481f2f187d2162c89c324c9ead4b6351ea9b50

Best regards,
-- 
Krzysztof Kozlowski <krzk@kernel.org>

