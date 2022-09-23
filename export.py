
"""export file."""
import argparse
import numpy as np

from mindspore import context, Tensor
from mindspore.train.serialization import export, load_param_into_net, load_checkpoint

from src.delf_model import Model as DELF

parser = argparse.ArgumentParser(description='Export MINDIR')
parser.add_argument("--device_id", type=int, default=0, help="Device id")
parser.add_argument('--ckpt_path', type=str, default='')

args = parser.parse_known_args()[0]

context.set_context(mode=context.GRAPH_MODE, device_target="Ascend", device_id=args.device_id)

if __name__ == '__main__':

    delf_net = DELF(state="test")
    param_dict = load_checkpoint(args.ckpt_path)
    load_param_into_net(delf_net, param_dict)

    input_batch = Tensor(np.random.uniform(
        -1.0, 1.0, size=(7, 3, 2048, 2048)).astype(np.float32))

    export(delf_net, input_batch, file_name='DELF_MindIR', file_format='MINDIR')
    print("Export successfully!")
