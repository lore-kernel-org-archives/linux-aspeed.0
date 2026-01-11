Return-Path: <linux-aspeed+bounces-3279-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E54C7D2502E
	for <linux-aspeed@archiver.kernel.org>; Sun, 11 Jan 2026 23:11:50 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dqB8w4506z2ykf;
	Mon, 12 Jan 2026 10:11:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=74.125.224.45
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768162331;
	cv=none; b=QW78QJQtYTYEdK0YxrmDSCEYj2yd5MyC90ICLZrUdb6AdAnZ+/jHC8C6uPEG0qixMhYa1pNUjtqukWqcE8T0BeBPsbSpKM5FkCcYN/po8yZYySc6OQaD1wY7EfY0glOs5+KSlWoLK0cSD9Cxpj/m75CNYfhFfsHX8a4JD0BcHap+E6C6a4do8r18D/hXi0SdE0FLr3TQ6twbCHbHVWidDgbckWT0937Svpyxc5h7fKDzMDhLUTBVYNBeFkCo1ZFH784i8mNBq24+LDDty48IylAp320RIZN4IEUE2bg1oFOn5tUpBzmWyhEM7npfuf2QIWzcHnr2WuUX3qup1NhTSA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768162331; c=relaxed/relaxed;
	bh=3WjMx6HuwU1Wy+8RcNWFYu7YuaIy2oBjUVHx01Ru4Xc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VeTzNqLqafpEsJOvRh8A11zaCEMhg/z0hA/HNUgPJK/pi9WgnAvV9b0EISDrSL71Hi66EKH7haWBOfFPHXDznJfFracaaO96c+Vyxzqr8sfLGeUHilb3ewFwiUYzRs7mX8OW4fz5nFcwhXFLr+oeT/e1yPHttvmDhkJjqRWlTTg6ZQAV9d7IeTuu30epd97Jsl4Q9K37hwAY0UeZNe8GOAb2Q6Zrd6Mh8+sG662rV9Zs6z6fMLHW4Zc8uS2aFNL5ySnZPrhn+QnncZSA0wjklkqjIJQu64sIXVuubeoI7K8Nm1RUcKehRs6lxExw0ARl6ZX3FAMxaq/ufS1f1iiowA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Sz+i4PU6; dkim-atps=neutral; spf=pass (client-ip=74.125.224.45; helo=mail-yx1-f45.google.com; envelope-from=anirudhsriniv@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Sz+i4PU6;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=74.125.224.45; helo=mail-yx1-f45.google.com; envelope-from=anirudhsriniv@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dq69j57CDz2yKp
	for <linux-aspeed@lists.ozlabs.org>; Mon, 12 Jan 2026 07:12:08 +1100 (AEDT)
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-6446c924f9eso5314135d50.1
        for <linux-aspeed@lists.ozlabs.org>; Sun, 11 Jan 2026 12:12:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768162265; x=1768767065; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3WjMx6HuwU1Wy+8RcNWFYu7YuaIy2oBjUVHx01Ru4Xc=;
        b=Sz+i4PU6Kawtw5eLvRDA6ZjKw4LIpgOJw85Ly88bFBLyDfS7Y92UHZxIQd1P3SHNHj
         KYN35uoy0OHQ1vS51fQznUYGh90pRpDs0t/Sbb8Gq1dtygWF+LNlHDOfzeEvQUQXDQfu
         fmZgvZaRqIWZpK8Nn4xXI+yOsWeyu3tf72MdM+5CiS2YYEIBUw2lYyQ5IhTZ7yY/8vbO
         NVc2W1fHpuaSFD34ud1WPFdrlXdWOcmucp/g/H9EOfcZMVBte7qtHN5LBdxuU1toaUXI
         TUldo+JLQX3GyTWke2bsA097lLhaZ2kn/b2oTh8dGicxMmbgiiDlCAu9RCAbxnQ7t+vu
         yC2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768162265; x=1768767065;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3WjMx6HuwU1Wy+8RcNWFYu7YuaIy2oBjUVHx01Ru4Xc=;
        b=J2achz09aobANQCoylj6j1UJB1pGQ3NlK8+og28sHZShavQilKTOH8nX6oiv7zEDRJ
         6qTuuuyi6XzAmOXMeEY2UXMmi886UT7RD5ztbkEiHDBoBqkNwAeMyJy4e1U7A8FOHSLp
         4ewCQhl5j0/7KOkc6Hz6neZCNmwrIWoOqp8Mv07GS8GZOlHjY8igOL+LlHc9Kx6kgfGB
         1SM6dukE+Ft8dN6s9A3hlX+83sNz0JFTNnx7tnwndsCBQURW/Cl9vDI/Sh4t7fvPGb8x
         oXqf1toH+lJyea9NWH1He3gHSHJglFL7pga5QmQJeuep7VMCuIBPGWvvdl+/P/wzJZ5Z
         Ug3A==
X-Forwarded-Encrypted: i=1; AJvYcCVvujxDN1hY7Lkcpw9mwuE944jwzM5Y9rE/2DQNPF+h/9yorlqidvqt7fBt0R9ZuEQhf6VXnbYN5OeJSyA=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzLcD3Xut1b3T8nXtAegp0zA8yQpSEqGD7mRjsKQ2qIUOBOVF8w
	qQsjHo2R8pNDhsl15dmXBC4JNcU7khE4HIFK/BMTkUsnXt22OYjoMMdh
X-Gm-Gg: AY/fxX5ZQ1SqpkPzCHeOqQ37bhMJ/w5sHR7amARN51xt1XLooNVsPrjD6U1irIvdVa8
	+tL3Uzl8ebtrM0OLU6MaXA0hHKip4Taxe3HuE/hUVYOPVnrUWiwSml3rshj2z+1AiVsJ9SODZwe
	wN6TOuYgETex2Nh/kjM14kW4N2WX+K5SCB7B+EOlRIpbN16FOLrvEQdXYIe0G2ti/gGoMWC39/M
	uA6/hU8la6nB1h6Q8hA/cdfTLsWZ2Vl4AE6M2zf4z7E03FQ1QplTiew57wVQ3vvoE1590SP7uB8
	Gj2V4NlDuuCyWTgk8M/rwsZ+dWgMN4qs5DMlAs3/4l1sDfAB9Z2F7SNcAGKzBGxl+nkMufx5fUb
	0XjhFXVI3LMm+fd8O7yFA4HNNs1Ji3hjeivrdU5agPHi2a2p07l0botMmoSNy9NDZVyB8
X-Google-Smtp-Source: AGHT+IGtpefdIwaz1zrj3LX0ANB3EkQVjPbjQhL8KzEpUBfzS7Z79abIt8/S9RwcfiKfM++zWNHWgQ==
X-Received: by 2002:a05:690e:12ca:b0:63f:b410:e93 with SMTP id 956f58d0204a3-64716bd1ba8mr12791408d50.42.1768162265218;
        Sun, 11 Jan 2026 12:11:05 -0800 (PST)
Received: from toolbx ([2600:1700:220:59e0::914])
        by smtp.googlemail.com with ESMTPSA id 00721157ae682-790aa5762f6sm62175717b3.15.2026.01.11.12.11.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jan 2026 12:11:04 -0800 (PST)
From: Anirudh Srinivasan <anirudhsriniv@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: anirudhsriniv@gmail.com,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] Add device tree for Asus IPMI Card
Date: Sun, 11 Jan 2026 14:10:30 -0600
Message-ID: <20260111201040.162880-1-anirudhsriniv@gmail.com>
X-Mailer: git-send-email 2.52.0
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
Content-Transfer-Encoding: 8bit

Adds support for Asus IPMI Card [1], which is a PCIe card with an
AST2600 on it that provides BMC functionality to any host without an
onboard BMC as long as it has a PCIe slot.

Currently supported functionality includes UART, NIC, booting from SPI,
KVM functionality(usb gadget for host, reading VGA framebuffer from
host) and LED/Power Control via GPIOs. This functionality has been
tested on an OpenBMC build available here [2]. This requires a modified
u-boot device tree [3], which I can also submit if needed.

The card supports some additional functionality in it's stock firmware
like fan headers with fan speed control, host bios flashing via SPI, PSU
monitoring via an SMBUS connector, a custom ASUS SMBUS connector to talk
to select ASUS motherboards that support it and exposing a IPMI device
via PCIe to the host. These are unsupported at the moment.


[1] https://www.asus.com/supportonly/ipmi%20expansion%20card/helpdesk_manual/
[2] https://github.com/openbmc/openbmc/compare/master...Genius1237:openbmc:asus-ipmi-card
[3] https://github.com/Genius1237/u-boot/commit/1b1b7daa85f6c998e5f404296b3da43077a2758e


Anirudh Srinivasan (2):
  dt-bindings: arm: aspeed: Add Asus IPMI card
  ARM: dts: aspeed: Add Asus IPMI card BMC

 .../bindings/arm/aspeed/aspeed.yaml           |   1 +
 arch/arm/boot/dts/aspeed/Makefile             |   1 +
 .../dts/aspeed/aspeed-bmc-asus-ipmi-card.dts  | 137 ++++++++++++++++++
 3 files changed, 139 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-asus-ipmi-card.dts

-- 
2.52.0


