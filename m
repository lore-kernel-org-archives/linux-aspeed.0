Return-Path: <linux-aspeed+bounces-2471-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38ACBCCD183
	for <linux-aspeed@archiver.kernel.org>; Thu, 16 Oct 2025 09:09:42 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cnMbS59xqz3c2k;
	Thu, 16 Oct 2025 20:09:40 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::42e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1760605780;
	cv=none; b=J19OFmsDJUmEVqsyHSzYpOVCDV7x5It/9kpSq9Q4CC9tGOwoWf9oW5B5WHOQHlwLsQh8tmnkWl4cGvm0mGvALF2d+Ynt3tN7LILpCMvpxsW4CzVzek6RKI6gDSzH3pxZyelynZma3MzVTWFJnj7L/WmRyZQSPJPKzw+JAFJH8m1x8tuYoHH1TdJUq/cz9U5e8+/XKz/1BBRzJnzDDv2CmtyTVU9MVjN4yV+SH/XhadOV9/TsiGEjDN4aJClhXkdtdDm6QS+FgKKWEcLT7eA81FcAl1IQ9w1OFYPdZpCuWvpxekD/ZxtSy6ElIK+rKIseQ9QQ1F0roEvqkuI/Wb7FGA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1760605780; c=relaxed/relaxed;
	bh=3XfGtDpvixDdEbcRz5vwuGcb2ROuArxfXHlo3yElQWM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=VLI9I3ZWRI9NGtvTHYXdm00DRl3EGexVD447FhH1H+GF0NJMJv4hiZpBRYo4DgDQxuUEXUl0bB6n6tUXwpwgyKa8qCkcq4kGMXsgAMEuNy1vvoDk12grAHqpA1RL8+arx7Zf4QQt3dATTKibSFOA+oxiJsn/nVXx4U585qt3T6SX+8JMN+oP5msH7/AmJPs4vvvSaHfFtSrvwFub7LD0Kd344mIiiABAhwnpcoldqstzDHNwlIXUSb72rDXOiFsWRnx2hf3niraITWBuYF86ZxdB057a71hdYw0KKuyuu7fZ7J0rbxyQrQftS1b7qSLjh7bWhHLkNJTkoMsI/E9PXQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; dkim=pass (2048-bit key; unprotected) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=HOgrIUpm; dkim-atps=neutral; spf=none (client-ip=2a00:1450:4864:20::42e; helo=mail-wr1-x42e.google.com; envelope-from=brgl@bgdev.pl; receiver=lists.ozlabs.org) smtp.mailfrom=bgdev.pl
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=HOgrIUpm;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=bgdev.pl (client-ip=2a00:1450:4864:20::42e; helo=mail-wr1-x42e.google.com; envelope-from=brgl@bgdev.pl; receiver=lists.ozlabs.org)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cnMbQ5nCsz3bjb
	for <linux-aspeed@lists.ozlabs.org>; Thu, 16 Oct 2025 20:09:38 +1100 (AEDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-426ff4f3ad4so199332f8f.0
        for <linux-aspeed@lists.ozlabs.org>; Thu, 16 Oct 2025 02:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1760605773; x=1761210573; darn=lists.ozlabs.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3XfGtDpvixDdEbcRz5vwuGcb2ROuArxfXHlo3yElQWM=;
        b=HOgrIUpmr+x1Iz/pVHkFAJheo8le61RjjHSQ29TbLHze+8K0syHwrjlWMTF5qJfkmL
         xl1mhoEu8LpGr9/lWzCPYG86OLmXqMDD0b2WlSfzXzzE7fK2m40EFiGKfRJlxkz0B5LZ
         4S79wsxtdS/L4IAk2p7DoXYBX6X2IhJUWZVfPvQbUgagJ/bxAVH1visRU48pGLJ6tw1a
         n3oyVpFVbuIkR35yCOVe4n3hpYLzJS/JQrNzahGRaZFd/FDL+nQSy6hO758523bl65QF
         efx11bp8By2GV4n6WMt2eZoBNohrh5xiSpj2eFjLoCVmi/3xrtE1cyVcc/6R6brYA/kT
         TVNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760605773; x=1761210573;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3XfGtDpvixDdEbcRz5vwuGcb2ROuArxfXHlo3yElQWM=;
        b=k3JqFbzFLs7z+Qk0CVEJdRraA46wBuXiH3zAoro8JtmouTxgEmoeIMavO09pqzqiPM
         f4asxpbC8SXcbexTHNf4mcwpzOp1BDIN3v8jeBYz0jRwboFdNXxOUnuw6eaMY1PoajJC
         GFaYOyUtEbjHOhvxROJ/mlZqld4UYjKDKvFwoXs4OYqbkpnBfF2HjV7Fn61Yz5xbIbWt
         b3hzcC3ZxFR8eHkxROGqV2Z6YgwWGIt8MCzOY93M/qP5KltEO47+K8KvEQbuiuovCIxB
         st2XQqX2kwNeEFn0YXlotB9eaIAHrXc3T7TjLe9S0PCl3cDILksIEM+87vgEfZhtfsu6
         zlsA==
X-Forwarded-Encrypted: i=1; AJvYcCVFW6OibK6qyFppJsf2MtBGVOW+Vkwm+Qoa1Hyk1oRJz+DTT1p9pW5xGoFrcX1YBPyqsUPgC1MqfN6xydw=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yxn7g7WmyhwauuyId38qDrTNRBdxd4t+CfbJIxnUIDClvuR03mE
	HjouoT1n2ij/Pk3d30wM/+/Z3CDD3oZoXdCIth/ga6SE9uSe+7OCxSER8uvgVyFucyk=
X-Gm-Gg: ASbGncujGUZTApaR9ujBCTzqrpavp9rY+Y+vwg0qLT0Qa//3+zd1I9t8lEvqp8zyaYt
	MVTjap8tpZxerJOrWW2sjtX9KsyOjov/Av/kz4UyjsAzCCfB2cXOkCcbcEXHyITSouHpRk6WD4T
	tG9xJWg9OZssf2L06VRyjd4b0SRKjzESek83zOxPqUc8DMNA2R2VoHxk7zv+l9K9H6Ou1YRKJZe
	L8eNaDCVabWfc57Q7R3cb95eOD9TdbHbVgDdyEk9LM03WViwtlkqNk+zHA3o3k02PKlkC3q2wF8
	N/Z1wr7sT6nKIcj780F09Dbay3ejEqTYBhe0EhJU6loYU6m98twXz3DROigF2En32/TeBhxLNAB
	k+FHXWamV7d3pVQyxxWxCduI2RuZnDiTEj/9jRnRrl/o57SeSsOC+PUwMw+tWLsbJTy15S0A=
X-Google-Smtp-Source: AGHT+IGiB5wh2xi45fqGt9AHQHRjpRW/BPh60+Svmei7EnochMvgfDKfftV2c/QbNugPLrF4Z4/urA==
X-Received: by 2002:a05:6000:288c:b0:425:75d7:c308 with SMTP id ffacd0b85a97d-4266e8dea0dmr19755334f8f.51.1760605773226;
        Thu, 16 Oct 2025 02:09:33 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:ef97:57cb:86cb:f7c4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5e1284sm33191287f8f.45.2025.10.16.02.09.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 02:09:32 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH 0/3] gpio: aspeed: remove the "gpiolib.h" include
Date: Thu, 16 Oct 2025 11:09:24 +0200
Message-Id: <20251016-aspeed-gpiolib-include-v1-0-31201c06d124@linaro.org>
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
X-B4-Tracking: v=1; b=H4sIAES28GgC/x3MQQqAIBBG4avErBtIy0VdJVpY/tVAmChFIN09a
 fkt3suUEAWJhipTxC1JTl+g6oqW3foNLK6YdKONapRhmwLgeAtyHjKz+OW4HFh3vW2N7rE6QyU
 OEas8/3ic3vcDmqOiCGgAAAA=
X-Change-ID: 20251015-aspeed-gpiolib-include-249a3529efd5
To: Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Kent Gibson <warthog618@gmail.com>
Cc: linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1080;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=/A0ZCcFCCbHISULOnXDBh9EbzVTgeCK0Cn6Fan3eR6s=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBo8LZH3arKi5byEXGVlxJX2oBym0TIUQaJt4vNT
 2Xhn80agZiJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaPC2RwAKCRARpy6gFHHX
 ch71EACPqE9VZd/9ZyXyN0sohSzOOWITHwl9w0/7pdKL5fhienPDAccVYCkftlwlyVuR6IEaINE
 NS8j/mdCrT4WJfa5s+32eqU7LcMma9kwO7ZGhRtYJlKJlRCOqV5RiNU5nWhrL179JY8i8iPNP2j
 8TTKj2+zZGarliK69rjNxfN8eO4CvMbnGQVQpOTz5q3ggMBC5Q+NFLn3ruJxDRYz/o/rbpmm8Ci
 P7emEyEGFOV99QTDHmfj9y6203ZN322qZSET6UBrW7GX3gMslcgtmhvROjfL00YyG4FLvkPomPR
 Qx6fQlJJ2zMgvQkWqwxxLt4Ga/Ms+c6mmL5fdINtDr55jP5jx1gw8i+akbhiimaDcacFIst0ghX
 ShGVHue+2vDlV9QUpLwG9kIX0yjmCFHhbvh0/ZRhE7z/YXSouMX7fPF8jE+ch1Ms++5w3fHU//b
 p4/BmPhBqEYvzFpNof0paEusUG6sAXvrkbNCKlis6m5JGWP59ZP/lsXbMkU0o+g6B6dK2kxrsdC
 DkpfSgbFD78BGPHNXaQMrrMb2E2HSUfcJpCAIAzZkFqK09WtU/NPIb+kj2LBq2LtYasZPMXcEqN
 kIUBHTzWzvWGnU+qpzKkEr9RdRB9L9sKakgDpWqIj5MutGTOA8KWZA+RYmeP+7GUZfmrLpRdxGT
 5W060Q0/Ve/5ewg==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

gpiolib.h is a header internal to the GPIO core. Drivers should not
include them. gpio-aspeed only needs to be able to determine the
hardware offset of the GPIO given the descriptor. Expose the relevant
symbol in the consumer header which allows us to stop pulling in the
private one.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
Bartosz Golaszewski (3):
      gpio: rename gpio_chip_hwgpio() to gpiod_hwgpio()
      gpio: export gpiod_hwgpio()
      gpio: aspeed: remove unneeded include

 drivers/gpio/gpio-aspeed.c    |  7 +++--
 drivers/gpio/gpiolib-cdev.c   | 12 ++++-----
 drivers/gpio/gpiolib-sysfs.c  | 14 +++++-----
 drivers/gpio/gpiolib.c        | 59 ++++++++++++++++++++++++++-----------------
 drivers/gpio/gpiolib.h        |  8 ------
 include/linux/gpio/consumer.h |  2 ++
 6 files changed, 54 insertions(+), 48 deletions(-)
---
base-commit: 13863a59e410cab46d26751941980dc8f088b9b3
change-id: 20251015-aspeed-gpiolib-include-249a3529efd5

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


