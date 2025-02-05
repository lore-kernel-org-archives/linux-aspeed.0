Return-Path: <linux-aspeed+bounces-661-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BDFAC02192
	for <linux-aspeed@archiver.kernel.org>; Wed,  5 Feb 2025 08:40:33 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Yntwc251Cz2yXY;
	Wed,  5 Feb 2025 19:40:32 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::42d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1738744832;
	cv=none; b=SYlAuPC6lzkSipqllAynhPvuM0d6PimHCjRSU1b70/YUS/ICSZb8NlsW+qxAJwkrwWaL3GCvFJKMo+U5apUFEtvjt0aq4puayZLaA64Ivn0XhR2N25VhqsUT6t8qnPQUowrv2ZUzI7DsQn9TwrNFHYKsAzZli73NZWwuNpAMwgvbN8VnOJy6zQ7o8CNgZR96tc8a2W/HTmboaNvn0VIhUgxGxd72oYnpbg2YOJb7WKkBHUiA/700DSGrXQtAMgpXGklw+zqG5hiCsyD0ygHoD9scgW/PZH7PiDNiGzP76Oo3UaOUA415zNs4LrfnC2RGrH24chBRfz62lYSUrUOsxg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1738744832; c=relaxed/relaxed;
	bh=+es5DswhUHJuqnAtb0R/kgWj5lIvrRgBlmdAByRuO1k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iHKUCsrVYfUeC7eieVe34sL/29NDDjHk03lWMgM4UXQwL9RBYcxm7fe6UWsG4Q6fWCn1VS/L1448ZfP7Mxqz5Jgffn8HLNI+nFEzpnhIDVHjp4ksRqvPTd5BW1I8FbBf9rX+vcbR+BwoZVwRAJ6hiBNB8W7Gxby9eijSMjcEJuTKSwVJ1+AXf8r12qqreWC2NuhtI7mgUQbuNlQkDOVka8L8PuFMb4CiUqLiYUrVpjQCilXtg3OXnig7qbxW9qolU0aa5iv3xSqkvvFqYHahw4BWQ+3MyClHBAbcARIsSGLe3PwTp9pzsrHpnrQdYfFlnCuzhQPT+7tCyfDkgDKiCA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; dkim=pass (2048-bit key; unprotected) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=eNIQ6A3b; dkim-atps=neutral; spf=none (client-ip=2a00:1450:4864:20::42d; helo=mail-wr1-x42d.google.com; envelope-from=brgl@bgdev.pl; receiver=lists.ozlabs.org) smtp.mailfrom=bgdev.pl
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=eNIQ6A3b;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=bgdev.pl (client-ip=2a00:1450:4864:20::42d; helo=mail-wr1-x42d.google.com; envelope-from=brgl@bgdev.pl; receiver=lists.ozlabs.org)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YntwZ1rMNz2yRM
	for <linux-aspeed@lists.ozlabs.org>; Wed,  5 Feb 2025 19:40:28 +1100 (AEDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-38633b5dbcfso6890332f8f.2
        for <linux-aspeed@lists.ozlabs.org>; Wed, 05 Feb 2025 00:40:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1738744824; x=1739349624; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+es5DswhUHJuqnAtb0R/kgWj5lIvrRgBlmdAByRuO1k=;
        b=eNIQ6A3bDP+fWJta4lHT7r3eSd57zm13W0vXW9vpmhWrb5Hk1MTvh/+ujuOrZbkEy4
         71btACYpgXqi2mzJSZTuqGee5FjRP/80osnbTFAMHUS9T72u+77aoKdmOGMEx0t1TP9g
         KYOFRHxOjkSTWbIE/d+yuFssfrAQlq7vsIPnvMZOdfuxL09nG894ffEwhyVWaoHE+r+i
         tXqOJ033cy+FYkyaQwkG6/m0Ddk3l9uZKSttONWK+ARqKE3X0hrze3cEFWfKWssxkS+t
         Ifngp+4OlInTd6a0RZfuX9MW6cLttMDSSdbQW/X4bPkLCj1u4eu7p+Z4plpNEo/kkGOl
         3wuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738744824; x=1739349624;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+es5DswhUHJuqnAtb0R/kgWj5lIvrRgBlmdAByRuO1k=;
        b=cqUVnWckBOg8pOPePyZ2S2EUL9k4jzlbmBPT4MgXcyppuoVVkghJxI2gYr1HE9fzmr
         vt7v4j8IOnzy96soxKQ9czbk5Eu5lxtipgeYAUf+1kG0CND7spxJqoUDuKL+WkOAjwiW
         9sJG6TyXmUUAyoq4+LrIH29l6mrww5EAsMWyjs/cZ8qYqt88tbO0ztsE+s9+46ZRxxpq
         57j5l3Y/rDpDYnyn3YTStwiQTu33uRXH8PlplWCTBg78U6pca4zIKgOWptlFzR7kLheI
         p1irthfY4ZWt3hlP90xWglh8UJYpRN/RdPiRswt+OqZEOy6JUbovZAJpX6qbFW94EfXw
         1aGQ==
X-Forwarded-Encrypted: i=1; AJvYcCXMVjWtlZBdZrBXdIlEV4EK3COFzkRD2eYPQCPQ/R4EPIODqTZmhWF5tVzgVx+yKVDDAVqkDR+lkavxD0c=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyHhq5YLo6mEagXbLemEj56b+HQzs3JAncvoIZaSeg1eTF/6uxe
	iVcv09HUrC6xqooMNdGKK3/HBpk2RRFaAr9+UCE5UZGNgmXNGId19e5HwcXlKa0=
X-Gm-Gg: ASbGnctlKpaTFfcn9xGVaLc/IK6163xgpG3sZJmg/dU/slM+FXHcE6Wua1yLjS9sJus
	O2rDA8b20lXtws1l6HZAbBHdxcxSFN7kgrZwHo5gDiGUe5CSux4XhOv/KSTZq5eOwqtMZgujKPq
	h2TWzZDIe3bloFYua1n2uct/+eYC+jLKFxAMoLzcAmpnUSJXzkeVKdSOVmp/QkxEyIaQ0guBXKV
	AQO+9jx6hOQ5UQngLsHWPmtYucfQvdgZrcy3ovAf7neWg9L8URsNy4AdpE6Oy+LTHB/BYPzgv24
	7C8WwKXK+duS+tg=
X-Google-Smtp-Source: AGHT+IHufl43yH4h42TNeRNb4pIxJfhWtSlcWpDN/3IHQPb679izKuQl7RiI9837Q+o9LDGQeygmhQ==
X-Received: by 2002:a5d:47a4:0:b0:38b:ec34:2d62 with SMTP id ffacd0b85a97d-38db48a0aa1mr1427352f8f.24.1738744823940;
        Wed, 05 Feb 2025 00:40:23 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:a766:1fb1:99b5:1d5f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38db6d7fb3dsm704259f8f.72.2025.02.05.00.40.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2025 00:40:23 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: brgl@bgdev.pl,
	linus.walleij@linaro.org,
	minyard@acm.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	openipmi-developer@lists.sourceforge.net,
	joel@jms.id.au,
	andrew@codeconstruct.com.au,
	devicetree@vger.kernel.org,
	eajames@linux.ibm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	Ninad Palsule <ninad@linux.ibm.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	andrew@lunn.ch
Subject: Re: (subset) [PATCH v9 0/9] DTS updates for system1 BMC
Date: Wed,  5 Feb 2025 09:40:21 +0100
Message-ID: <173874481706.6250.3472033617115260753.b4-ty@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250204194115.3899174-1-ninad@linux.ibm.com>
References: <20250204194115.3899174-1-ninad@linux.ibm.com>
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
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Tue, 04 Feb 2025 13:41:03 -0600, Ninad Palsule wrote:
> Please review the patch set version 9.
> 
> V9:
> 

Applied, thanks!

[2/9] dt-bindings: gpio: ast2400-gpio: Add hogs parsing
      commit: e8f2ca6be61f1cae2ff12932fa03224581b6b231

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

