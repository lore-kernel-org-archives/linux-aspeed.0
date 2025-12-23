Return-Path: <linux-aspeed+bounces-3219-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7877DD3B7E5
	for <linux-aspeed@archiver.kernel.org>; Mon, 29 Dec 2025 01:42:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dff8X71fmz2yFj;
	Mon, 29 Dec 2025 12:41:48 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1766507291;
	cv=none; b=EklV+vS9jyA4Qh7t3vxIxM+j2kpUGAD16lHEHb64W+bynzMO5wAFNw0VT754Re6SDf/+Gkfo+yKQHTipvg32o5VVzpSFWE8YFomFKLYGIRIyhY+29h2qJhV6tZwrenhrl9flpmUIWta9WgdIWk6XPDM+caXnMakt3SLStd2U5n//R4Gk/ULwWPVEG5z3ZE9nzCnjn36GcCP2TW3Qkb/hzwOX61m+Z3CVZZTx8vGYJqjv6RJj/dY13tq6kIufEltep5F+SkCqB6JdhUJTwZxJY6DWZsa/k0Xtk6Qp7wKdFhp4Oej5YEivf9EYYcjQb3MJbhja5edPC8TYZBHX/A2zSg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1766507291; c=relaxed/relaxed;
	bh=jiVMsPmbQP7FZ38DNLit/HG1+5z9nnDnXvMaFIBjNjQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=D6EY79Z8FvKSCGyJ1GW0M/xk9+BLJ4o4uM74dRI68W5lnHelwgEUUfzfFHY4qnD9V3CAuD1iAAa+n9uKSNmihEqQ99Ou4tAvDpiVJU81PNWBWmKzmF92P5zEFle7oEFqHWdcm1AMw1g41OujXRubXNGb0ludjo2sj6Cd+BYxtbpYoh1fRa6B1jUff9pF0cGUQRbq+e5KlAJQOQ560OW1jj4tH6P+vXJEoc/0rpg139QIFiZUtXAhtxA7xOI+UQStepI8d2eDc0PhFr3AtlQeHGRv99ruBuJPf3KJ6gY40iD6JbHxwvNwUWWYdPv8Y0F+rmywBgktXiAWzh3MYv94jg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=dY21izoQ; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=kVId+lS3; dkim-atps=neutral; spf=pass (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=manivannan.sadhasivam@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=dY21izoQ;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=kVId+lS3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=manivannan.sadhasivam@oss.qualcomm.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 1771 seconds by postgrey-1.37 at boromir; Wed, 24 Dec 2025 03:28:09 AEDT
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dbL612grMz2xXB
	for <linux-aspeed@lists.ozlabs.org>; Wed, 24 Dec 2025 03:28:08 +1100 (AEDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BNErsbV461342
	for <linux-aspeed@lists.ozlabs.org>; Tue, 23 Dec 2025 15:58:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jiVMsPmbQP7FZ38DNLit/HG1+5z9nnDnXvMaFIBjNjQ=; b=dY21izoQwZl3PUWu
	Mb6XE3I9EdcKQO8QjSqkx5MLvjiEwvp7/oOdtyn2XSuWlTf3zVnBSDfvpxeh+aLG
	uQViOdMN53cJFkPMxDxc7Tz0MrWKgjfFGwWea8YMW8CmOrD3Q9+uVH0+5tnsI3Ed
	vxfom/ISfZ5X0F9jEgVbRIeCNtAtVoQ28hzi3zolpSY+3CY1+Dtd3NVZJYHXipJu
	fTZdrdKIAAJ/Pd8qfzGX1MKPf2bTnUOKAR/WlTEpR4vdpBVwdecu0c2rn7UvVrN/
	YmCQbg4NE2gSVOFz90F80BXLJDXxr/mJHWJxz2cna19+/98SeU6WkHbCYNzBY/kS
	QCAYsA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b7w8fr62d-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-aspeed@lists.ozlabs.org>; Tue, 23 Dec 2025 15:58:34 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2a0dabc192eso113153235ad.0
        for <linux-aspeed@lists.ozlabs.org>; Tue, 23 Dec 2025 07:58:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766505514; x=1767110314; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jiVMsPmbQP7FZ38DNLit/HG1+5z9nnDnXvMaFIBjNjQ=;
        b=kVId+lS3Zc9kUThkytI3LwpDH8v9wPim4uns4iPGuVsuXZEj/FeaDFHRGIbkkfLGMP
         EnZDTvqgMP2PzlJlZns+ugepgdnfCURiIeETFa0pHXR7oFoVEZ8mXv4PC0UGr9v8AMk0
         hHGDV9PRHo13gcTSgv8afe0/7jDZ1OwcYOB36eTAZ4aL1hwGdWNGYToRS7Y9a++DDizo
         djPS92xpytg8QMxCycoVyoOpGxGZ/sAsK2zxWZ1qn9jdrm4CM/nhg4u2GuEkgxAKy1TX
         6xat6iCh1SVQh/msZNRI0fSt8NhbBSjULuXbCHYN7pDJqHZjX4QVqBle7G5wqEhsMRAi
         nVew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766505514; x=1767110314;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jiVMsPmbQP7FZ38DNLit/HG1+5z9nnDnXvMaFIBjNjQ=;
        b=dIMiXRW48kOWDtitnXVimrsWcHWSAcgdBT8ir10lxc33/VihG+fwQA+1dj/eEMsg8O
         bTgRFsltULZQrc3avqjXsHQLB+46rsmpnyDdh8jn5jdZ8vEXFCPLYLUCtEfWTS2OYCCE
         yAubanMnYepBnzo92/oZ1nhh6oVJhmgVJifcH8Cmflpp/ROFoyDR7MIrRmM5573fsHqx
         klrCQ52Qfiq2STEeBKSU9rMLnh4v2i8qczRzMlYs7rmPQoBhWfR6nYhZcEbjNICsp2sJ
         Ig9Jw6AqyRDg3qP3lrNE8qPn0uKhRuu5NU6CGbVpLK2tmfOBuxwSvuaaUNFfYV2IYNcH
         lwoA==
X-Gm-Message-State: AOJu0YzGHS+iXVuIAql88+j93etSsBZAiJ0aw/fDQCC8NuA/M2v619Y5
	hPuXOk8PMkz1WED0JKzCI+HBO05eJtqOUv0jE4vFk7cs66Dgg2iJAUx7Ixf+6BwxWJSS3RxPmKt
	EpBIeQ5+KjFoFKjh+cL8TJ60mG9KPKlqEoiNvSzRr+6ikfeAPSs9qYtjMpV+TCkr17dkz
X-Gm-Gg: AY/fxX4K/yboZT7TckCAwtMGELFonTbfcqWKxK80vgH6q076T99HUU9dBTThSOEWZhE
	8IFrNoWSpAW3cYxw4IssnZiL6CW6XR4HvkJNJSAsMvAANFkgGDnFL7T0iu2ehiR9rWR12Bg5kpD
	QYX0q7pE6QxUGbjwPVhOT7ZgbnUwgu9YudX8uzmQYLtd12wSI6AaQe6SOqAF+GzOCFz6EkZB33Z
	A6Q0k/Dz0n7QKldIYJnlwy/Ztfus3Bl8z63zRPGsXHRis8YIVIVf93An36BkmrAXos81myJSHV+
	1TDOsj1h795cC4PmH0a2uUzxDU58aG5CA7SuPKe5hUhNkUa55chqHRNaulzv48WV8fe1jAegMzM
	VDRdN+uh4bQ==
X-Received: by 2002:a17:902:d584:b0:29e:9c82:a91e with SMTP id d9443c01a7336-2a2f21fc506mr163295525ad.7.1766505514309;
        Tue, 23 Dec 2025 07:58:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFhayM1D+7Y1gHqun6N5dRaivrEs0mEAHPs1q25xLW/IAzFnLc7m+vKUO2bdvStmAZD+ZHRIQ==
X-Received: by 2002:a17:902:d584:b0:29e:9c82:a91e with SMTP id d9443c01a7336-2a2f21fc506mr163295255ad.7.1766505513842;
        Tue, 23 Dec 2025 07:58:33 -0800 (PST)
Received: from [192.168.1.102] ([120.56.200.112])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3d7754asm131271795ad.100.2025.12.23.07.58.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 07:58:33 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@codeconstruct.com.au>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Jacky Chou <jacky_chou@aspeedtech.com>
Cc: linux-aspeed@lists.ozlabs.org, linux-pci@vger.kernel.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Andrew Jeffery <andrew@aj.id.au>, openbmc@lists.ozlabs.org,
        linux-gpio@vger.kernel.org
In-Reply-To: <20251216-upstream_pcie_rc-v7-0-4aeb0f53c4ce@aspeedtech.com>
References: <20251216-upstream_pcie_rc-v7-0-4aeb0f53c4ce@aspeedtech.com>
Subject: Re: (subset) [PATCH v7 0/7] Add ASPEED PCIe Root Complex support
Message-Id: <176650550798.2188958.10356654881464455126.b4-ty@kernel.org>
Date: Tue, 23 Dec 2025 21:28:27 +0530
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
X-Mailer: b4 0.14.3
X-Proofpoint-GUID: OxpctcupLV0bktuoAJ0Bl-4SQE8qu8ir
X-Proofpoint-ORIG-GUID: OxpctcupLV0bktuoAJ0Bl-4SQE8qu8ir
X-Authority-Analysis: v=2.4 cv=QutTHFyd c=1 sm=1 tr=0 ts=694abc2a cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=31AEnvkI3DvSdtIumApubw==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=oUgZFhhkZxxgqap4hUAA:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjIzMDEzMiBTYWx0ZWRfX6fmnPbmqd7u2
 GC8+VyUz6jhx4iSXnrxKuOoHAO/cMv3YJROwYzFV0pziI8GxPVv8wJ+wDMYqY5I9zorB76lIak6
 XzQDkIkUCd7OLkgnw9kA3LffhglhmwG7Ljc5b3jofK1mhxp+ea13WW4+sEuNPx79H4PAAjcvdWD
 rIEB/aObg/WxLFW3Nmudr46lyOGH4SVQe/K0aB2o1/9RO5MvE5k3Wnq00RPmEpcZCBCSiuHM2pf
 UZVhMqVgFfp2turM7hN77dxJ/YgILtZL7sskbRGC7tZz7yeL7m5fxxk2Gfx71nFSemK2lHVYwzt
 r4OpqxZSSIV3cgg+xsl+ojfP0+U2BhLnNAdgv83kJ+Nd6lRnIp3iIqQm9WsdpdRkX+DLiSpT5DY
 BZxQaIYHuwAoBD5CNdPFl4tBOKkRwLHmiHVfV3KW09K25mpTr73OvlCinVhMj7bBe6D8RxYh/X2
 1jO9TJDsP8xP5j3kL7Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-23_03,2025-12-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 bulkscore=0 impostorscore=0 spamscore=0
 malwarescore=0 clxscore=1011 lowpriorityscore=0 priorityscore=1501
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2512230132


On Tue, 16 Dec 2025 09:49:59 +0800, Jacky Chou wrote:
> This patch series adds support for the ASPEED PCIe Root Complex,
> including device tree bindings, pinctrl support, and the PCIe host controller
> driver. The patches introduce the necessary device tree nodes, pinmux groups,
> and driver implementation to enable PCIe functionality on ASPEED platforms.
> Currently, the ASPEED PCIe Root Complex only supports a single port.
> 
> Summary of changes:
> - Add device tree binding documents for ASPEED PCIe PHY and PCIe RC
> - Update MAINTAINERS for new bindings and driver
> - Implement ASPEED PCIe PHY driver
> - Implement ASPEED PCIe Root Complex host controller driver
> 
> [...]

Applied, thanks!

[2/7] dt-bindings: PCI: Add ASPEED PCIe RC support
      commit: a20df1a7683d6c1416c0f56fb737554b9abe9959
[5/7] PCI: Add FMT, TYPE and CPL status definition for TLP header
      commit: 73ce5ba701a53ad89c623a641401288844f526ac
[6/7] PCI: aspeed: Add ASPEED PCIe RC driver
      commit: 9aa0cb68fcc16280c8c8bdd22dc770af8dd7349f
[7/7] MAINTAINERS: Add ASPEED PCIe RC driver
      commit: e5c2061442dda716fb08cc4eff485220c94e6475

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>


