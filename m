Return-Path: <linux-aspeed+bounces-3379-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9509C9830C
	for <linux-aspeed@archiver.kernel.org>; Sun, 18 Jan 2026 23:21:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dvV2W6Sgjz2yFm;
	Mon, 19 Jan 2026 10:21:07 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768759816;
	cv=none; b=ETXB4Fx6mDtAvF6kRg30msopNJPsWh7S9fT3+eRNHh8F6fggS27paLuTqaQyPCQwfw5eN/3WJXuOxT4RyGBwjcpCgj4HRIzZmh6rkWLUKEd3VZ+v3Q27Vm6DAwjoQc04oBHJvP4lmJK5dJr7y+x8lOt9Lrp2vkLtBcftMwtlKI0XW+V8AiBA83FM4mgfsQHvXfXirheeQFs3lmikCMcRM4cgejOdy6ulz5qzX8m5C1WIKnVJk0/+UPLFq0pmt917RdIrZgdUajbNY7YxgyyaebElwa8DT4IOB0rqfT+YzS1ESj4yV3hQOv610szbRf4nAJTA9iY81AHD++b9k5w9ag==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768759816; c=relaxed/relaxed;
	bh=LXncEA4jW+AgdDM8Dn/nTshgL+Kv2q2dFOJVpt182v4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RWYfjvzsAn3+mNHrh1guhxDa11lXzErvK9CdMB74Bn2mpoXP9Bie8ynQMgWkbqkb9RQBvkxLrFGAsxxUScLpSivVBjH0f1pnuXf2avoDovXy+1wPBi6q4Ge2Wlhdn4dv5jqr40Mkpexef4AGoM9guyFka5MQ1d7wqslMPv1W+8kp4EPgZc1QGQBv+Jmc6c8rCM3+t/hNH6MQzoGLV3lfX9KCmj71dart/2AgqP10H1+Upw0UdpgLYHhhU2mpoxpohtOVtSGiMxTJyujav8cp6GsDvw3gcE+8IlVOQID+t7FGPO4n1omv2C5Z26VHlEo1KJ3xImnl3TUVl8xmmxCq0A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=KXHpX1m8; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=P331a3Z9; dkim-atps=neutral; spf=pass (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=krzysztof.kozlowski@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=KXHpX1m8;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=P331a3Z9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=krzysztof.kozlowski@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dvM7r1lhQz2xSZ
	for <linux-aspeed@lists.ozlabs.org>; Mon, 19 Jan 2026 05:10:16 +1100 (AEDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60I0t7ph3192119
	for <linux-aspeed@lists.ozlabs.org>; Sun, 18 Jan 2026 18:10:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LXncEA4jW+AgdDM8Dn/nTshgL+Kv2q2dFOJVpt182v4=; b=KXHpX1m8m3rn36Jg
	XAOXwYt+u9K3TjPostd/Ga+OJGx79TdYs516hJ7Uuj1DP0pic1AGnEgszDSbZwne
	PlDfhwKpRxALzLVi9/aOTpk6UditMnDm/26xLFGDtbrHEDQ8D8GdH0lLQR4Svsqo
	pnP7iEh9mMwx8zLBM9tlTFKD5OpkE0j97kbRdyVpYBq944m/m/NN6wbfgx+b0Do/
	6FHtL3IJp+oK9lZqxZHck0q7vU3B3O9QpoRqSvP9CfcaD0RXSV07ytsg3tCUjcGe
	ow5J9jBBcx1u5RbtkPZs81+1yN/7xDoG6TjVaRHXngafujCzRFemL8NSl76wwWQ1
	/MK8Jw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4br3kh2mck-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-aspeed@lists.ozlabs.org>; Sun, 18 Jan 2026 18:10:14 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8c6a0ec2496so717974885a.1
        for <linux-aspeed@lists.ozlabs.org>; Sun, 18 Jan 2026 10:10:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768759813; x=1769364613; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LXncEA4jW+AgdDM8Dn/nTshgL+Kv2q2dFOJVpt182v4=;
        b=P331a3Z967y7bbbpC6Y5KkjRzKz4IKMIscrlshxnFd/q4fpiHkjcvxyJybkNExUSvq
         9m5bjNfTrSGRhEfFEykte2tOLR1ZlDW1Dq78DaznO2y+/LO5QUrC2ExLQJwsxZhNqWt6
         nwcsz/ZiMb5ttYqST25qJiWjgqbHcjaKeLZdha96XoVXSFTRX2a9U9HzyhwPsx/fCv0w
         oM5a27Wfa2+54ha2SF+GFiE79bLdsrbzwzkBAztC45cjiOMhViiMmt9Tlsx40/XpzF4a
         qwWohQ+4Bg6hFj5YVNlf/3PuW3KtZGOxcne/W9JZ4k21/5Si2SlRoqJmS5JJZrO6UNsn
         p7ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768759813; x=1769364613;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LXncEA4jW+AgdDM8Dn/nTshgL+Kv2q2dFOJVpt182v4=;
        b=Bh6MHkx058f9El7CJdETsiNyJESFBjFU/hCoX6YYeoqHHXDS6ueOBsqcJrsLf5FPC7
         W2bf35J4zy6Dd7Xbx3UOGfmv1jL+TaRNb76ncIUbG2MDVXqgUHdPK2slbXxMG+zU7o53
         28UITbU7cccvD9N4TCUIhJadX2NGxW2EvKDIhdb9fDhGucyjmISyd6Az1+K8t5OqrkH/
         qu4LyVFmPckBJJnO6fJxz5+XVAx6M1FKjI3O1u0Q49d0SI1GA5ZIPa17fTae3q2zwvAZ
         x/CPdyjKJM6izZZmcZcvpXhZXP+iHZsJT2GnGq5IkhebYPprbbsu6+EXZeqcp8MpHcUb
         yCEQ==
X-Gm-Message-State: AOJu0YzT8wNv6lY9MJS2ahKWlUqrzKYeN4FokMqnaYnW6Ld9dkleM3jC
	/W9wMx1oWAAQzc4jR1xTeVzwV0o27d/f4K76Nol8sfd9Djc6rAyA3mJWgmxi1RVSpgbS78iWOuV
	0K9aC6dF2LMdAmJ8gORXHCK3pOhi1vWo8wxLpwZ24sp8c7AkDOKT8jRITpsSQhPn2ZSDW
X-Gm-Gg: AY/fxX4icPLo8w85GFUKpAsctJZGBGMp+2McE2dDQePbg7bi/I1VZ+Dhphe+Nm88qAJ
	fg82j9ZDuh/9kJrXlgmlmCroxRO0NTtgMOs8LUDjpMj8ssR/TXKOEClMG/w242UhH4FhrjwUy5V
	TuV7HrKik4P9QRsAs8Kmahysj/1/Q//oQTXxrlktL9XmzQ+pRXnlfNGo+bRVaf6SXM+yNJsUOJX
	qxzWv7upLdYpnmihbe6nVqalMHsxWPooV6DVFsLQvD0FI+AIWA4STSJ1YPonFK5u41wKyfvCmZp
	Ry2m3Ii46QL+3HsuggCTjtxqIPpQzdUu0xx+keA1SXRXq5UrAoBkSHPjJ2S7M2QIbTyZEstr5FJ
	hACVCb5LXo3MJNjZMbpGRMyqx97Xa+WquDw==
X-Received: by 2002:a05:620a:4801:b0:89e:67a9:fced with SMTP id af79cd13be357-8c6a6789e6bmr1223537285a.66.1768759813362;
        Sun, 18 Jan 2026 10:10:13 -0800 (PST)
X-Received: by 2002:a05:620a:4801:b0:89e:67a9:fced with SMTP id af79cd13be357-8c6a6789e6bmr1223533585a.66.1768759812755;
        Sun, 18 Jan 2026 10:10:12 -0800 (PST)
Received: from [127.0.1.1] ([178.197.218.229])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4801fe44b37sm62162085e9.12.2026.01.18.10.10.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jan 2026 10:10:12 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Date: Sun, 18 Jan 2026 19:09:28 +0100
Subject: [PATCH v2 05/11] pinctrl: aw9523: Simplify locking with guard()
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
Message-Id: <20260118-pinctrl-cleanup-guard-v2-5-bd36f681bdc0@oss.qualcomm.com>
References: <20260118-pinctrl-cleanup-guard-v2-0-bd36f681bdc0@oss.qualcomm.com>
In-Reply-To: <20260118-pinctrl-cleanup-guard-v2-0-bd36f681bdc0@oss.qualcomm.com>
To: Andrew Jeffery <andrew@codeconstruct.com.au>,
        Linus Walleij <linusw@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Hal Feng <hal.feng@starfivetech.com>,
        Chen Wang <unicorn_wang@outlook.com>,
        Inochi Amaoto <inochiama@gmail.com>,
        Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Steen Hegelund <Steen.Hegelund@microchip.com>,
        Daniel Machon <daniel.machon@microchip.com>,
        UNGLinuxDriver@microchip.com,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Patrice Chotard <patrice.chotard@foss.st.com>
Cc: linux-aspeed@lists.ozlabs.org, openbmc@lists.ozlabs.org,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, sophgo@lists.linux.dev,
        linux-tegra@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4481;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=Y+FQmd4rABqYPyTPKLcnkK9CTadziXSgsQ+69hWhimA=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpbSHyayuoBeIp9CFs/To0KGzg5wtCKMQchY4rd
 ZTVsgBVTRyJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaW0h8gAKCRDBN2bmhouD
 18jKD/0Q73dFNHHnrM5068MUNMPnIOmN7objobVATcjCxeNYoQiN8W7ivD4SWKVqA/DdX1R5St3
 0/tCDBGqXO12+uj40UIZE4ljdgKCD+fsn+WSOyeGFeJIxnFDyd8A6kCV+M957Av09NHGOuZzCz1
 n84LPH3ZRBC3uEP8gG7lVsIgTJ7Wd71Udx4I6Tf07bk7F2r+44NHCHKRtu55X8WAjRvLmynm86Z
 YOKnbZ2UCIUPJ62n3gMymM0/Ir+JkYjini6adzG92nXecsMf8J7ulbe3ZCqT5uJ5jTnZRR3KKGb
 psXi0oNg+Osb0wrW5nqR6O2Im3Oqs44dXVV3i/kbow6pNJeKSmmU5W+l68bvNbT281ghjvLIslY
 vvnRwxod3eZUawpDeP6T//3MNuKK2Gg8x9Lq9ey+ddE7nCFUTBA3ypX1ErFjwFg0DHDk12c8WII
 gi08BdhYaU8LtIxZzranwWhmvK3EgkrmYF+5lIoiIaY0e8XcmSW8WsiZCwrGUt/cBly3O7IY92Y
 FNoDXLaqmlFiFgTiMN2tVA1DpqquhFr/7fQp130j1BwOiRjF1OVqoVodqNKRPARHoBOIEmZMpIC
 PcI+/h6wyzJPyYXnC1UAQaCuoEGdkdUU7RcbXCWBfUmrFfqNlwHm1DgkCLMLdyMmi3GmnFcSM1m
 fHjfP614CxYOwQA==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE4MDE1OSBTYWx0ZWRfXyLWHZM6w5FXs
 5yeTSS1CizKB14/J1F5XSQ4aFQkX6xD3Dbi8nZEjffBZYDd+cyXpVG+gFStW7O8EGdGDVjHIEDI
 XRVNLO26K8NCBaplKv3Flf378gtsaBrEGsZZGP8ar2oRqrRkmS9evkFgObq5PwGv2bcCGnHbGEa
 5DIX1dKnmZU6isGaIH5wlfnR2L2nzcEt6C1LKS97nkhrOjPGtrZneOWJ4iSn9yrBXoycgMLpu04
 l7tr/npF7F7wf4DihObaU46yGXnB77ZMSihiQdh2/Oy0NaNwa1BqyS3XRd1N62uXYK44ly5B/tU
 oKLyLKmw5LDONUMmqi1tu//8hFTNo7jFzYj+7AGyBTY5Xn75gilqp1IWoo3CWkFKteD8Lr3FKeE
 ScWy5dqGKKCk0/kphos5pJo9J5BGHBmahIC1YtbwmuOC4U/K0RpG6XIhbXOEhxQcD40+x7FnWm9
 ulVG3WpK7RYfjBRkQtw==
X-Proofpoint-ORIG-GUID: UDN12gIzL2Tlgvih4E73LV6VUe9QvRhB
X-Authority-Analysis: v=2.4 cv=JcyxbEKV c=1 sm=1 tr=0 ts=696d2206 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=Eb9f15NH/cHKzfGOmZSO4Q==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=sJPWbbE6un6nfY-uGV8A:9
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: UDN12gIzL2Tlgvih4E73LV6VUe9QvRhB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-17_03,2026-01-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 impostorscore=0 adultscore=0 phishscore=0
 malwarescore=0 spamscore=0 bulkscore=0 suspectscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601180159

Simplify error handling (less gotos) over locks with guard() which also
removes possibility (at least by reading the code) of returning
uninitialized rc/ret value in aw9523_pconf_set() and
aw9523_gpio_get_multiple() functions.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 drivers/pinctrl/pinctrl-aw9523.c | 53 +++++++++++++++++-----------------------
 1 file changed, 23 insertions(+), 30 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-aw9523.c b/drivers/pinctrl/pinctrl-aw9523.c
index 479553a79216..02a24ac87ea4 100644
--- a/drivers/pinctrl/pinctrl-aw9523.c
+++ b/drivers/pinctrl/pinctrl-aw9523.c
@@ -291,14 +291,14 @@ static int aw9523_pconf_set(struct pinctrl_dev *pctldev, unsigned int pin,
 	unsigned int mask, val;
 	int i, rc;
 
-	mutex_lock(&awi->i2c_lock);
+	guard(mutex)(&awi->i2c_lock);
 	for (i = 0; i < num_configs; i++) {
 		param = pinconf_to_config_param(configs[i]);
 		arg = pinconf_to_config_argument(configs[i]);
 
 		rc = aw9523_pcfg_param_to_reg(param, pin, &reg);
 		if (rc)
-			goto end;
+			return rc;
 
 		switch (param) {
 		case PIN_CONFIG_LEVEL:
@@ -307,7 +307,7 @@ static int aw9523_pconf_set(struct pinctrl_dev *pctldev, unsigned int pin,
 						AW9523_REG_CONF_STATE(pin),
 						BIT(regbit), 0);
 			if (rc)
-				goto end;
+				return rc;
 
 			/* Then, fall through to config output level */
 			fallthrough;
@@ -323,10 +323,9 @@ static int aw9523_pconf_set(struct pinctrl_dev *pctldev, unsigned int pin,
 			break;
 		case PIN_CONFIG_DRIVE_OPEN_DRAIN:
 			/* Open-Drain is supported only on port 0 */
-			if (pin >= AW9523_PINS_PER_PORT) {
-				rc = -ENOTSUPP;
-				goto end;
-			}
+			if (pin >= AW9523_PINS_PER_PORT)
+				return -ENOTSUPP;
+
 			mask = AW9523_GCR_GPOMD_MASK;
 			val = 0;
 			break;
@@ -341,17 +340,15 @@ static int aw9523_pconf_set(struct pinctrl_dev *pctldev, unsigned int pin,
 			val = AW9523_GCR_GPOMD_MASK;
 			break;
 		default:
-			rc = -ENOTSUPP;
-			goto end;
+			return -ENOTSUPP;
 		}
 
 		rc = regmap_update_bits(awi->regmap, reg, mask, val);
 		if (rc)
-			goto end;
+			return rc;
 	}
-end:
-	mutex_unlock(&awi->i2c_lock);
-	return rc;
+
+	return 0;
 }
 
 static const struct pinconf_ops aw9523_pinconf_ops = {
@@ -599,14 +596,14 @@ static int aw9523_gpio_get_multiple(struct gpio_chip *chip,
 	u8 m, state = 0;
 	int ret;
 
-	mutex_lock(&awi->i2c_lock);
+	guard(mutex)(&awi->i2c_lock);
 
 	/* Port 0 (gpio 0-7) */
 	m = *mask;
 	if (m) {
 		ret = _aw9523_gpio_get_multiple(awi, 0, &state, m);
 		if (ret)
-			goto out;
+			return ret;
 	}
 	*bits = state;
 
@@ -616,13 +613,12 @@ static int aw9523_gpio_get_multiple(struct gpio_chip *chip,
 		ret = _aw9523_gpio_get_multiple(awi, AW9523_PINS_PER_PORT,
 						&state, m);
 		if (ret)
-			goto out;
+			return ret;
 
 		*bits |= (state << 8);
 	}
-out:
-	mutex_unlock(&awi->i2c_lock);
-	return ret;
+
+	return 0;
 }
 
 static int aw9523_gpio_set_multiple(struct gpio_chip *chip,
@@ -632,30 +628,28 @@ static int aw9523_gpio_set_multiple(struct gpio_chip *chip,
 	struct aw9523 *awi = gpiochip_get_data(chip);
 	u8 mask_lo, mask_hi, bits_lo, bits_hi;
 	unsigned int reg;
-	int ret = 0;
+	int ret;
 
 	mask_lo = *mask;
 	mask_hi = *mask >> 8;
 	bits_lo = *bits;
 	bits_hi = *bits >> 8;
 
-	mutex_lock(&awi->i2c_lock);
+	guard(mutex)(&awi->i2c_lock);
 	if (mask_hi) {
 		reg = AW9523_REG_OUT_STATE(AW9523_PINS_PER_PORT);
 		ret = regmap_write_bits(awi->regmap, reg, mask_hi, bits_hi);
 		if (ret)
-			goto out;
+			return ret;
 	}
 	if (mask_lo) {
 		reg = AW9523_REG_OUT_STATE(0);
 		ret = regmap_write_bits(awi->regmap, reg, mask_lo, bits_lo);
 		if (ret)
-			goto out;
+			return ret;
 	}
 
-out:
-	mutex_unlock(&awi->i2c_lock);
-	return ret;
+	return 0;
 }
 
 static int aw9523_gpio_set(struct gpio_chip *chip, unsigned int offset,
@@ -695,16 +689,15 @@ static int aw9523_direction_output(struct gpio_chip *chip,
 	u8 regbit = offset % AW9523_PINS_PER_PORT;
 	int ret;
 
-	mutex_lock(&awi->i2c_lock);
+	guard(mutex)(&awi->i2c_lock);
 	ret = regmap_update_bits(awi->regmap, AW9523_REG_OUT_STATE(offset),
 				 BIT(regbit), value ? BIT(regbit) : 0);
 	if (ret)
-		goto end;
+		return ret;
 
 	ret = regmap_update_bits(awi->regmap, AW9523_REG_CONF_STATE(offset),
 				 BIT(regbit), 0);
-end:
-	mutex_unlock(&awi->i2c_lock);
+
 	return ret;
 }
 

-- 
2.51.0


