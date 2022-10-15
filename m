From: Quan Nguyen <quan@os.amperecomputing.com>
Date: Sat, 15 Oct 2022 10:24:26 +0700
Subject: [PATCH v10 1/3] ipmi: ssif_bmc: Add SSIF BMC driver
In-Reply-To: <20221014130517.y4mdinylnwfrg6u2@ggregory-linuxws>
References: <20221004093106.1653317-1-quan@os.amperecomputing.com>
 <20221004093106.1653317-2-quan@os.amperecomputing.com>
 <5fbc5a54-60f2-fc0d-a4a1-839f28a4d8ba@quicinc.com>
 <48a5e252-9a1e-65e6-e8bf-add3d39a0286@os.amperecomputing.com>
 <72c8a5bc-830d-25a9-0528-5d428dd9f163@quicinc.com>
 <20221014130517.y4mdinylnwfrg6u2@ggregory-linuxws>
Message-ID: <634209c7-e458-8c4c-7bef-63f283aefaf7@os.amperecomputing.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On 14/10/2022 20:05, Graeme Gregory wrote:
> On Mon, Oct 10, 2022 at 12:08:24PM +0100, Graeme Gregory wrote:
>>
>> On 10/10/2022 02:28, Quan Nguyen wrote:
>>>
>>>
>>> On 07/10/2022 20:26, Graeme Gregory wrote:
>>>>
>>>> On 04/10/2022 10:31, Quan Nguyen wrote:
>>>>> The SMBus system interface (SSIF) IPMI BMC driver can be used to
>>>>> perform
>>>>> in-band IPMI communication with their host in management (BMC) side.
>>>>>
>>>>> Thanks Dan for the copy_from_user() fix in the link below.
>>>>>
>>>>> Link: https://lore.kernel.org/linux-arm-kernel/20220310114119.13736-4-quan at os.amperecomputing.com/
>>>>> Signed-off-by: Quan Nguyen <quan@os.amperecomputing.com>
>>>>
>>>> I have been testing this on our hardware and I don't seem to be able
>>>> to get this driver working. I was using an older version.
>>>>
>>>> I have hacked ssifbridged to deal with the change in len from u8 to
>>>> unsigned int.
>>>>
>>>> It works as long as I only ever send SSIF commands, any attempt to
>>>> read a response crashes the state machine and the driver never
>>>> recovers. No further SSIF comms is possible! (slave doesnt even ACK
>>>> writes).
>>>>
>>>> A couple of comments below on possible state machine errors.
>>>>
>>>> Its possible I am doing something wrong!
>>>>
>>>
>>> Thanks Graeme for the test and the comments.
>>>
>>> What's your testing hardware?
>>>
>>> This was tested with Aspeed ast2500 and ast2600 with the patch series
>>> [1] below applied.
>>>
>>> If you use the same hw, could you pick the series and see if any thing
>>> improve ?
>>>
>>> [1] https://lore.kernel.org/all/20210616031046.2317-1-quan at os.amperecomputing.com/
>>>
>> Thanks, that patch series does stop the state machine crashing.
>>
>> I am testing on AST2600EVB with A1 rev, but we also have our own DC-SCM with
>> A3 chip.
>>
>> Responses are still not working for me, but I think that may be an error in
>> my ssifbridged hacks.
>>
>> Oct 10 10:54:55 qcom-evb-proto-ccf37d18ea0c ssifbridged[335]: Read ssif
>> request message with len=13 netfn=44 lun=0 cmd=2
>>
>> Oct 10 10:54:55 qcom-evb-proto-ccf37d18ea0c ipmid[312]: BootCode:
>> 000000000000000000
>>
>> Oct 10 10:54:55 qcom-evb-proto-ccf37d18ea0c ssifbridged[335]: Send ssif
>> respond message with len=4 netfn=45 lun=0 cmd=2 cc=0
>>
>> Oct 10 10:54:55 qcom-evb-proto-ccf37d18ea0c kernel: ipmi-ssif-host 0-0010:
>> Warn: on_read_requested_event unexpected READ REQUESTED in state=SSIF_READY
>>
>> Oct 10 10:54:55 qcom-evb-proto-ccf37d18ea0c kernel: ipmi-ssif-host 0-0010:
>> Warn: on_stop_event unexpected SLAVE STOP in state=SSIF_ABORTING
>>
> Just to close the loop on this, I have now fully tested this driver on
> our setup internally.
> 
> Final hitch turned out to be an aardvark not issuing STOP events between
> reads/writes.
> 
> Thanks for the work.
> 

Thanks a lot Graeme, for the test.

- Quan
