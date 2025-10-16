Return-Path: <linux-aspeed+bounces-2474-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCA8DCCD1A1
	for <linux-aspeed@archiver.kernel.org>; Thu, 16 Oct 2025 09:09:44 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cnMbV5Rb2z3cBW;
	Thu, 16 Oct 2025 20:09:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::335"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1760605782;
	cv=none; b=PPgengUERLjKnxo/cvOYjtigzJNCD2rHTxYbie5v1635GXKcw4YaJ7icM2fcQHCTFJYVE94iL66+F1iXbQ5E9vFBhw5Eqs2nF+X15AKlhsOv1ALSyOG6kVQ0osZe/rLnliHT0kG9UGBz9UjiWHXbEk/HH43AFPRIgWrG9VtmPn99C1g7bmvLO/9fpvj72UxPE/uUmlFNr2SFsUdGeylinY9cSjjq5kS9RH4+kugJl+k+R2O3NVCgPFaLkTQoW94LMlOtt8H8FLC3JjnrViwaEkbm1LeP88MCfA443zW/8a/M3oPhcLKG5Mkon30Oyyf/QS1QSHLGG8u9DONjAlBvYw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1760605782; c=relaxed/relaxed;
	bh=giyJvu+P/c/zBlzgMeJooxdfh7qZjl2zxl4gZFBxF6g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XIJAJrVnAJOPEM+0hSwXBNgCwTgTJIi+YUL+TTkZws+ytqCnnAvzhtAARpnfR2SP6vOyWpqWxm+rP95jcnsp/AH2xci1sg1Ad791JSTK/AReYxw4tU2/zZiYnKrJ3T3Ns2A9oGJmD4NLA+TNi6GeUPjw30Gc6NKN8XtYckCn34TzUnpqoapcCijpNaItS2OHJzI7vFuAu76whRkaKXfFzYsuJjIS4wBZOURDpQVs36Ti8UWIQ5iYahS0t1YTbd752fCA1B0l8+nP4GkCezgeqGzu01118vIcM7F9g4eJMRoMMSz4C5lP6tf+5tiZMSf3vrMm2P3w81L4ViWfGTbumg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; dkim=pass (2048-bit key; unprotected) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=QRVzMjpZ; dkim-atps=neutral; spf=none (client-ip=2a00:1450:4864:20::335; helo=mail-wm1-x335.google.com; envelope-from=brgl@bgdev.pl; receiver=lists.ozlabs.org) smtp.mailfrom=bgdev.pl
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=QRVzMjpZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=bgdev.pl (client-ip=2a00:1450:4864:20::335; helo=mail-wm1-x335.google.com; envelope-from=brgl@bgdev.pl; receiver=lists.ozlabs.org)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cnMbT65Drz3bvd
	for <linux-aspeed@lists.ozlabs.org>; Thu, 16 Oct 2025 20:09:41 +1100 (AEDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-46e542196c7so10686675e9.0
        for <linux-aspeed@lists.ozlabs.org>; Thu, 16 Oct 2025 02:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1760605778; x=1761210578; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=giyJvu+P/c/zBlzgMeJooxdfh7qZjl2zxl4gZFBxF6g=;
        b=QRVzMjpZcrNse+r0LlYWBhD3M+8wDRPFuxKnqHcjJFkfO+fX7r2O6uCC69sjkwoyXk
         yQFt6ECUd31DDl9RWaGner/aR4BIs1RqLIlMXIFGYaS56in1U856NVackqzH773j2BAF
         ctHy4rMoKnRs0rot5b2zDT/o2TlFMejjmbRkG+kekZYx5LcFb6lPLSgJmXgKwBIkl3w8
         NDNCozr5sJ2Mrd1/7bk4S3f1ATC0/Rjzw3++7kS1RWngcdx+3dwYnAEhieFS6NhMMcEi
         mB0mh9A9QVZ8EGry/4ET8w3iWZ1lPHxtCXbCMHNS8KiTWMtWTGaDUz7Wzub1UdWFlZu1
         j7DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760605778; x=1761210578;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=giyJvu+P/c/zBlzgMeJooxdfh7qZjl2zxl4gZFBxF6g=;
        b=eVT4eUY7L1twEi/w4/reOQX4bJZ5E7c2rHs3iSfY10y61H3l1Pk1QTTBtXg19BbCgq
         8sB6svRBZeR7wj4u5OhO2RhpUJEGRcihE40scVGbyEMWk1AU6EDRRs6Hc3QvJu/O97kK
         7+iZPa9UwalgpCUcTPsPSp+aE1zMGbna9gbllFcSSacK/i3QKY3NZqGV6jymQ1BWUjFs
         VD0M14aiyhaw69iL0sM4HyjRWJbFVmg1rLk7MrpZ2MpCmfoVtoTuPMFo1H6uolfing3U
         /PMe9OXXU6bPzlEhtp+IMqJk1lTtGqA9WdtSKbsiE7bWK4n1LGazhwJDMM4Il7jaEPBI
         TvTA==
X-Forwarded-Encrypted: i=1; AJvYcCV1muh+mPIUS0vRZc0Lp3teG43nvitB3njHtrZYotrXgox/yJR1vXjvqm23iSofwDIQHP4xd9MxiVw0XVc=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzdT3iGd2KTwBfqUYnZnqaKIkKlLl09ULAmD/PjZ1d3GeN1FZqa
	J6RsYdUL+X6kAa7Z+CyXtUfirHpThdTfGJcfZxFhK5BIDTE0sTM8v6MWXucPMgzw2uU=
X-Gm-Gg: ASbGncvzuTtIcn+iaLUJnxEdnygMSowFyRxue//drvAQwgoeFVBVVmkgIvc7FqpkVR6
	Sr1I2rc4OduAbvKegyvbb4jXcTWGGanamZbRAm8If9sugw9HknDAeJ3Bdm8WD6uCWE7iR9DG9sq
	J8Vmw7Jn6QZg6FYnpDMy5SwrWtHJrEnCFwM+pH2/2vPXQSHCFF21n4AH1kzbxT33JtZ52/oYbld
	CfjtPXTAlzp2/YdMOTzw3vPZdIyikdZK7yGtQ+yNOGw2nm8SrxYXfrLZR84CCxWmpPlwGckBazB
	CNJ1wFjwiv7o0TFFZDocmvrIJSfvM6vBG0HoTv027rIv4Bvu3SjDTnBXRUGtec83XbvQn4djty2
	5sgwY5j03BH7QfRqD/2+w8bs5Hol4tMmONnPccJm40kTRc9l+HIKyEQAVeDwW8bErs0+k4C8=
X-Google-Smtp-Source: AGHT+IFwQ1Vj0TPDw4e4cKls5YWKHTovuMxKu9ae74FALGIc/dMLGZ2EBvJ6JtiJA1WjhvYyV1IDeg==
X-Received: by 2002:a05:6000:41d1:b0:426:f9d3:2feb with SMTP id ffacd0b85a97d-426fb7ab9e7mr2401645f8f.23.1760605778274;
        Thu, 16 Oct 2025 02:09:38 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:ef97:57cb:86cb:f7c4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5e1284sm33191287f8f.45.2025.10.16.02.09.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 02:09:36 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 16 Oct 2025 11:09:27 +0200
Subject: [PATCH 3/3] gpio: aspeed: remove unneeded include
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
Message-Id: <20251016-aspeed-gpiolib-include-v1-3-31201c06d124@linaro.org>
References: <20251016-aspeed-gpiolib-include-v1-0-31201c06d124@linaro.org>
In-Reply-To: <20251016-aspeed-gpiolib-include-v1-0-31201c06d124@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Kent Gibson <warthog618@gmail.com>
Cc: linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=807;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=AnELVPWhjXwv4nNT8oy1ky6Ra8SlMALj94FDJwWeEnQ=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBo8LZMRCng48xJlmYCAnXgnelIsEpfURlPAafHW
 lkDOwc8RISJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaPC2TAAKCRARpy6gFHHX
 cjRHD/4gn97X2frtT0cloiZdcc6gGioOaf4UKJ2xeM/W83SKU24VRhJufxQDYnRAKZUHwS3vM0i
 5xRJI7ZSCBEnwcdXUYP//E4XMsNeG6l2QtsNGOVTiPZbHyJ3ABGl3gUHq0Yo+l8hgkzmtee8CBv
 izSfKQzKXubIdTaHH4hPG36fHFwPfHqYfWgy2SJhEsD2fqmKm/2bdpMKZFQ2b0rQaCjWjMGSCEE
 SnR3F25qf/1xIPbT41uHEwbR4AYuiNPe0jb1OiA9oZC/8zrXc2vuja1rUHsCdGJ4FJ/oZA2c1vw
 gh8Op0XLF4Z01G1BZNgc7VHxLvbokm0xXzhbogh1mi5KTEkK9F+Zt9N24rsbha3jTZkDkidO6zF
 jymTl5YWnc2pOmONTe8zmUEC4gwXBQWj04uOFs2iUw69r3/q02w6dtJkPdV02tyUVE6OFS9HA9i
 XysJDFCxs6ffsLaYUNaL0zsTTHARF7WVLqqp2wUNjix0lAB5NeoIdGq3cUo454LYGRt5Op56xs3
 MnmGoKC7rP88mtSv9/zVDuGuNW5gXczxzLEMiwfkRkEQlIjuSqHTuTPDT/RcD5cmX/4Zzclpi0k
 LBdw9fVriRvRaBoxsYsIScwPxGHPGgGrEpmwKx6qgVMDvzkur6TQ5U6cJXuDRKo2sOF6Xa0n8H6
 uysm6NlVANuLgOQ==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

This driver no longer uses any symbols from the GPIOLIB internal header.
We can now drop the gpiolib.h include.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpio-aspeed.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpio/gpio-aspeed.c b/drivers/gpio/gpio-aspeed.c
index 3da37a0fda3fbdcb8077c07706aa41b233e9beeb..2e0ae953dd996ec1dbe7585c4a92f28622f8e39e 100644
--- a/drivers/gpio/gpio-aspeed.c
+++ b/drivers/gpio/gpio-aspeed.c
@@ -29,7 +29,6 @@
  * access to some GPIOs and to arbitrate between coprocessor and ARM.
  */
 #include <linux/gpio/consumer.h>
-#include "gpiolib.h"
 
 /* Non-constant mask variant of FIELD_GET() and FIELD_PREP() */
 #define field_get(_mask, _reg)	(((_reg) & (_mask)) >> (ffs(_mask) - 1))

-- 
2.48.1


