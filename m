Return-Path: <linux-aspeed+bounces-506-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BCA1C02183
	for <linux-aspeed@archiver.kernel.org>; Thu, 16 Jan 2025 15:16:37 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YYmfq6PBbz30Mn;
	Fri, 17 Jan 2025 02:16:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1737040595;
	cv=none; b=V95nGaaP88kkcS+baWimUJYS4GPVRg21OblGQSWwpIr4IxIjPqxCf/Ep0vbIcJ2Otmwz7cHOZLyG5PKyfjLyDYLcYEf8Qp7LhxCIAQ+HCHl5KkTcwbAiqd3cTiyZekl+ktH2DBu+SbZ+o8aKxqy2+BGLLcZkSFK1UkQY1gK5hovf7qb13yqgy1/suTI3/hvoA5Qj6nTaQz+qvs1Uvn4UWYj/n04THQ4/mCj5JVP3xZhs1695C+3X9zuwVcWBAkkK/nU9RxFsAwuQSKTKd8TmhylHeEIjrUrQSOkb4BaoytmkRtFFGqiKRrfwq0iBf0LbmVgKuydnYvERDtcMluFc+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1737040595; c=relaxed/relaxed;
	bh=YdlWU5uHCS6BCpki15J5p47gd8bkNXmYAGt43QgM2/c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JuwumUdRjUf5Y94//fc0QHjgklK41l7HeXPliIT+t+vYV5QGlhA+jz2QHGWCnqbNiw8iJeKeGuVxa4K9tQ1/cGzpZaTyUqfeQdnepwvlxoB6CdGnbeBbfR8TZX292VBB8husG6SUT4sO57A61pJGQ0PHE0Dp+89rwsdlHP1phtMIWSiluqw2LH9J4RQYY7hx8Q/oetHXiXCS5ZeLbslUBOXZswOz0QhbFfgZwtedwCf4t2U+qi2maTP79ixDFWJ5o1K5Z3dbc6PcIlce1hZLK7FPRfeRpNuABn45f5GLhhVDBpAETiD9NYwEF486s1nQSV6xC6hrTOI2T/9T/HKviQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=jJKfTCI0; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=ninad@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=jJKfTCI0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=ninad@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YYmfp6ZjQz30Ff
	for <linux-aspeed@lists.ozlabs.org>; Fri, 17 Jan 2025 02:16:34 +1100 (AEDT)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50G85bZm020393;
	Thu, 16 Jan 2025 15:16:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=YdlWU5
	uHCS6BCpki15J5p47gd8bkNXmYAGt43QgM2/c=; b=jJKfTCI0ZUQFfQTMFyBDSo
	bcKiIqdOoYMz7FZs6J6mIbOTtrvPcx43H3O+GzhgikIFqKEC5xL7UIsM/YGAdw+s
	rY7RyhbA/bwP29iGd3QQ5nbRwdED32I3/ZzBiTVoMs2DD4EF9BqZdbhO+/tHRZ9Z
	cwg22N0MEDzJj8t09Asjy6ROnUjvIPI/LbrFQ5VsvjK1uyFfL3IjLcjqaz4NmYxL
	IkjMbIYG8v8HXz7XcgX/EHyT0BUhf68SOYF40rhsbgnuK1DW5lKLN04O7h5q+pBF
	C3EqJmnk/LDjv2NdY/AiYXuRGeAPjiTpihsHBRZThGimOuxbVklxgZ/XyzQdqMNQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 446xa3a2dq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jan 2025 15:16:03 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 50GEu1dE031417;
	Thu, 16 Jan 2025 15:16:03 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 446xa3a2dm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jan 2025 15:16:03 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50GDn4kB017359;
	Thu, 16 Jan 2025 15:16:02 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4444fkeaky-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jan 2025 15:16:02 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50GFG21F8389282
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Jan 2025 15:16:02 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1235B58055;
	Thu, 16 Jan 2025 15:16:02 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 04EF75803F;
	Thu, 16 Jan 2025 15:15:58 +0000 (GMT)
Received: from [9.61.59.21] (unknown [9.61.59.21])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 16 Jan 2025 15:15:57 +0000 (GMT)
Message-ID: <98c24ee1-3a02-4df9-b181-22f3e6676b85@linux.ibm.com>
Date: Thu, 16 Jan 2025 09:15:56 -0600
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
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 00/10] DTS updates for system1 BMC
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-kernel@vger.kernel.org, openipmi-developer@lists.sourceforge.net,
        pabeni@redhat.com, krzk+dt@kernel.org, kuba@kernel.org, joel@jms.id.au,
        linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
        davem@davemloft.net, eajames@linux.ibm.com,
        andrew@codeconstruct.com.au, andrew+netdev@lunn.ch, minyard@acm.org,
        edumazet@google.com, conor+dt@kernel.org, netdev@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20250114220147.757075-1-ninad@linux.ibm.com>
 <173690506198.2128017.15705512689029125898.robh@kernel.org>
Content-Language: en-US
From: Ninad Palsule <ninad@linux.ibm.com>
In-Reply-To: <173690506198.2128017.15705512689029125898.robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: pOwtUgxf4sevROlKDeyLe7g0iyYEuZGT
X-Proofpoint-ORIG-GUID: O3vTPOgjhkVxMFnsseHc2nuO1G_oFbHE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-16_06,2025-01-16_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 bulkscore=0 clxscore=1015 adultscore=0 mlxlogscore=839 priorityscore=1501
 suspectscore=0 spamscore=0 phishscore=0 impostorscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501160114

Hello Rob,

On 1/14/25 19:40, Rob Herring (Arm) wrote:
> make sure dt-schema is up to date:
>
>    pip3 install dtschema --upgrade
>
>
> New warnings running 'make CHECK_DTBS=y for arch/arm/boot/dts/aspeed/' for 20250114220147.757075-1-ninad@linux.ibm.com:
>
> arch/arm/boot/dts/aspeed/aspeed-bmc-opp-palmetto.dtb: gpio@1e780000: 'pin_func_mode0', 'pin_func_mode1', 'pin_func_mode2', 'pin_gpio_a0', 'pin_gpio_a1', 'pin_gpio_b1', 'pin_gpio_b2', 'pin_gpio_b7', 'pin_gpio_d1', 'pin_gpio_f1', 'pin_gpio_f4', 'pin_gpio_f5', 'pin_gpio_f7', 'pin_gpio_g3', 'pin_gpio_g4', 'pin_gpio_g5', 'pin_gpio_h0', 'pin_gpio_h1', 'pin_gpio_h2', 'pin_gpio_h7' do not match any of the regexes: '^(hog-[0-9]+|.+-hog(-[0-9]+)?)$', 'pinctrl-[0-9]+'
> 	from schema $id: http://devicetree.org/schemas/gpio/aspeed,ast2400-gpio.yaml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-delta-ahe50dc.dtb: gpio@1e780000: 'doom-guardrail' does not match any of the regexes: '^(hog-[0-9]+|.+-hog(-[0-9]+)?)$', 'pinctrl-[0-9]+'
> 	from schema $id: http://devicetree.org/schemas/gpio/aspeed,ast2400-gpio.yaml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-opp-romulus.dtb: gpio@1e780000: 'nic_func_mode0', 'nic_func_mode1', 'seq_cont' do not match any of the regexes: '^(hog-[0-9]+|.+-hog(-[0-9]+)?)$', 'pinctrl-[0-9]+'
> 	from schema $id: http://devicetree.org/schemas/gpio/aspeed,ast2400-gpio.yaml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-opp-lanyang.dtb: gpio@1e780000: 'pin_gpio_aa6', 'pin_gpio_aa7', 'pin_gpio_ab0', 'pin_gpio_b0', 'pin_gpio_b5', 'pin_gpio_h5', 'pin_gpio_z2' do not match any of the regexes: '^(hog-[0-9]+|.+-hog(-[0-9]+)?)$', 'pinctrl-[0-9]+'
> 	from schema $id: http://devicetree.org/schemas/gpio/aspeed,ast2400-gpio.yaml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-bytedance-g220a.dtb: gpio@1e780000: 'pin_gpio_b6', 'pin_gpio_i3' do not match any of the regexes: '^(hog-[0-9]+|.+-hog(-[0-9]+)?)$', 'pinctrl-[0-9]+'
> 	from schema $id: http://devicetree.org/schemas/gpio/aspeed,ast2400-gpio.yaml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-everest.dtb: gpio@1e780000: 'usb_power' does not match any of the regexes: '^(hog-[0-9]+|.+-hog(-[0-9]+)?)$', 'pinctrl-[0-9]+'
> 	from schema $id: http://devicetree.org/schemas/gpio/aspeed,ast2400-gpio.yaml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-e3c246d4i.dtb: gpio@1e780000: 'bmc-ready' does not match any of the regexes: '^(hog-[0-9]+|.+-hog(-[0-9]+)?)$', 'pinctrl-[0-9]+'
> 	from schema $id: http://devicetree.org/schemas/gpio/aspeed,ast2400-gpio.yaml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier.dtb: gpio@1e780000: 'i2c3_mux_oe_n', 'usb_power' do not match any of the regexes: '^(hog-[0-9]+|.+-hog(-[0-9]+)?)$', 'pinctrl-[0-9]+'
> 	from schema $id: http://devicetree.org/schemas/gpio/aspeed,ast2400-gpio.yaml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtjade.dtb: gpio@1e780000: 'bmc-ready' does not match any of the regexes: '^(hog-[0-9]+|.+-hog(-[0-9]+)?)$', 'pinctrl-[0-9]+'
> 	from schema $id: http://devicetree.org/schemas/gpio/aspeed,ast2400-gpio.yaml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier-1s4u.dtb: gpio@1e780000: 'i2c3_mux_oe_n', 'usb_power' do not match any of the regexes: '^(hog-[0-9]+|.+-hog(-[0-9]+)?)$', 'pinctrl-[0-9]+'
> 	from schema $id: http://devicetree.org/schemas/gpio/aspeed,ast2400-gpio.yaml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier-4u.dtb: gpio@1e780000: 'i2c3_mux_oe_n', 'usb_power' do not match any of the regexes: '^(hog-[0-9]+|.+-hog(-[0-9]+)?)$', 'pinctrl-[0-9]+'
> 	from schema $id: http://devicetree.org/schemas/gpio/aspeed,ast2400-gpio.yaml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-bonnell.dtb: gpio@1e780000: 'usb_power' does not match any of the regexes: '^(hog-[0-9]+|.+-hog(-[0-9]+)?)$', 'pinctrl-[0-9]+'
> 	from schema $id: http://devicetree.org/schemas/gpio/aspeed,ast2400-gpio.yaml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-opp-nicole.dtb: gpio@1e780000: 'func_mode0', 'func_mode1', 'func_mode2', 'ncsi_cfg', 'seq_cont' do not match any of the regexes: '^(hog-[0-9]+|.+-hog(-[0-9]+)?)$', 'pinctrl-[0-9]+'
> 	from schema $id: http://devicetree.org/schemas/gpio/aspeed,ast2400-gpio.yaml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-lenovo-hr855xg2.dtb: gpio@1e780000: 'pin_gpio_a1', 'pin_gpio_a3', 'pin_gpio_aa0', 'pin_gpio_aa4', 'pin_gpio_ab3', 'pin_gpio_ac6', 'pin_gpio_b5', 'pin_gpio_b7', 'pin_gpio_e0', 'pin_gpio_e2', 'pin_gpio_e5', 'pin_gpio_e6', 'pin_gpio_f0', 'pin_gpio_f1', 'pin_gpio_f2', 'pin_gpio_f3', 'pin_gpio_f4', 'pin_gpio_f6', 'pin_gpio_g7', 'pin_gpio_h6', 'pin_gpio_i3', 'pin_gpio_j1', 'pin_gpio_j2', 'pin_gpio_j3', 'pin_gpio_l0', 'pin_gpio_l1', 'pin_gpio_l4', 'pin_gpio_l5', 'pin_gpio_r6', 'pin_gpio_r7', 'pin_gpio_s1', 'pin_gpio_s2', 'pin_gpio_s6', 'pin_gpio_z3' do not match any of the regexes: '^(hog-[0-9]+|.+-hog(-[0-9]+)?)$', 'pinctrl-[0-9]+'
> 	from schema $id: http://devicetree.org/schemas/gpio/aspeed,ast2400-gpio.yaml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-lenovo-hr630.dtb: gpio@1e780000: 'pin_gpio_aa0', 'pin_gpio_aa5', 'pin_gpio_b5', 'pin_gpio_f0', 'pin_gpio_f3', 'pin_gpio_f4', 'pin_gpio_f5', 'pin_gpio_g4', 'pin_gpio_g7', 'pin_gpio_h2', 'pin_gpio_h3', 'pin_gpio_i3', 'pin_gpio_j2', 'pin_gpio_j3', 'pin_gpio_s2', 'pin_gpio_s4', 'pin_gpio_s6', 'pin_gpio_y0', 'pin_gpio_y1', 'pin_gpio_z0', 'pin_gpio_z2', 'pin_gpio_z3', 'pin_gpio_z7' do not match any of the regexes: '^(hog-[0-9]+|.+-hog(-[0-9]+)?)$', 'pinctrl-[0-9]+'
> 	from schema $id: http://devicetree.org/schemas/gpio/aspeed,ast2400-gpio.yaml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-opp-zaius.dtb: gpio@1e780000: 'line_bmc_i2c2_sw_rst_n', 'line_bmc_i2c5_sw_rst_n', 'line_iso_u146_en', 'ncsi_mux_en_n' do not match any of the regexes: '^(hog-[0-9]+|.+-hog(-[0-9]+)?)$', 'pinctrl-[0-9]+'
> 	from schema $id: http://devicetree.org/schemas/gpio/aspeed,ast2400-gpio.yaml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-arm-stardragon4800-rep2.dtb: gpio@1e780000: 'pin_gpio_c7', 'pin_gpio_d1' do not match any of the regexes: '^(hog-[0-9]+|.+-hog(-[0-9]+)?)$', 'pinctrl-[0-9]+'
> 	from schema $id: http://devicetree.org/schemas/gpio/aspeed,ast2400-gpio.yaml#

This patchset fixes this issue. 
https://lore.kernel.org/linux-kernel/20250116090009.87338-1-krzysztof.kozlowski@linaro.org/

Thanks & Regards,

Ninad


